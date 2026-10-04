# Draft upstream report (NOT FILED)

> Status: draft only. This report has not been filed anywhere. Before filing, make this
> repository public (or attach its contents) and re-run `just matrix` against the newest
> releases.

## Routing (in order)

1. **espressif/llvm-project**, primary. It owns the Xtensa backend in every esp
   toolchain: https://github.com/espressif/llvm-project/issues/new. Rust-originated
   Xtensa codegen bugs are already filed there (for example
   https://github.com/espressif/llvm-project/issues/134, which links
   https://github.com/esp-rs/rust/issues/270). No existing issue about realign, movsp,
   stack alignment or CachePadded was found.
2. **esp-rs/rust**, a short tracking issue that links to (1): https://github.com/esp-rs/rust/issues/new.
   The impact is on Rust std (`std::sync::mpsc` constructors) on `*-espidf` targets.
   Similar cross-links: https://github.com/esp-rs/rust/issues/278 and
   https://github.com/esp-rs/rust/issues/283. Community channel: Matrix
   `#esp-rs:matrix.org`.
3. Optional: **llvm/llvm-project** with the `backend:Xtensa` label. Upstream main has
   the same `emitPrologue` code:
   https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/Xtensa/XtensaFrameLowering.cpp.

**Not rust-lang/rust.** `xtensa-esp32s3-espidf` and `xtensa-esp32s3-none-elf` are Tier 3
targets, and the documented toolchain is the esp-rs fork built against Espressif's LLVM
(https://doc.rust-lang.org/rustc/platform-support/xtensa.html,
https://doc.rust-lang.org/rustc/platform-support/esp-idf.html).

---

## Title

[Xtensa] Windowed-ABI stack realignment changes SP with `add` instead of `movsp`, so a window spill corrupts the caller's base save area

## Summary

For a function whose `MaxAlign > 32`, `XtensaFrameLowering::emitPrologue` realigns the
stack pointer right after `entry` with a plain `ADD a1, a1, aX`. Under the windowed ABI,
moving SP after `entry` requires `MOVSP`. The caller's `a0`–`a3` base save area sits at
`[SP-16 .. SP)`, and `movsp` is what relocates it, or raises the Alloca exception when
the caller's window is already spilled.

If a window overflow or interrupt-driven spill happens between `entry` and the `add`, the
caller's registers are saved below the old SP. ESP-IDF's `_xt_context_save` spills all
windows on every interrupt. When the function later executes `retw`, the underflow
handler reloads them from below the new SP and gets stale data. The caller then resumes
with a corrupted return address, stack pointer or arguments.

We hit this in production Rust firmware on ESP32-S3. `std::sync::mpmc::sync_channel` and
`std::sync::mpmc::channel` have `CachePadded` (`#[repr(align(64))]`) locals, and the
crash was a `StoreProhibited` through a garbage return-slot pointer immediately after
`sync_channel` returned. Only those functions in a ~4 MB image carried the pattern.

## Minimal reproducer (LLVM IR)

```llvm
declare void @use(ptr)

define void @realign() {
entry:
  %buf = alloca [64 x i8], align 64
  call void @use(ptr %buf)
  ret void
}
```

```
$ llc -mtriple=xtensa -mcpu=esp32s3 -O2 realign.ll -o -
realign:
	entry	a1, 160
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a1, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8        ; <-- SP changed without movsp
	addi	a10, a1, 0
	l32r	a8, .LCPI0_0
	callx8	a8
	retw.n
```

Equivalent reproducers:

- C, with Espressif clang:
  `void use(void*); void f(void){ _Alignas(64) char b[64]; use(b); }`, built with
  `clang --target=xtensa-esp-elf -mcpu=esp32s3 -O2 -S`.
- Rust, with the esp toolchain: a `#[repr(align(64))]` local passed to
  `core::hint::black_box`, built with
  `cargo +esp rustc --release --target xtensa-esp32s3-none-elf -Zbuild-std=core -- --emit=asm`.
- Rust std on `xtensa-esp32s3-espidf` at opt-level `z` or `s`: any call to
  `std::sync::mpsc::sync_channel` or `channel`.

The full reproducer repo has scripts, a checker and a version matrix: `<link to
pRizz/xtensa-movsp-realign-repro once public>`.

## Expected

A windowed-ABI-safe realignment. Compute the aligned SP in a scratch register, then use
`movsp`:

```
entry   a1, N
movi.n  a8, MaxAlign-1
movi.n  a9, MaxAlign
and     a8, a1, a8        ; from SP, not FP
sub     a8, a9, a8
add.n   a8, a1, a8
movsp   a1, a8
```

The other option is to reject or handle over-alignment some other way, for example by
addressing over-aligned objects through an aligned base register while leaving SP
alone.

## Actual

The prologue ends with `ADD SP, SP, RegMisAlign`. In upstream main and in
espressif/llvm-project `xtensa_release_19.1.2`, `release/esp_22.x` and the
`esp-22.1.4_20260825` release, `XtensaFrameLowering::emitPrologue` does this:

```cpp
if (MaxAlignment > 32) {
  TII.loadImmediate(MBB, MBBI, &RegMisAlign, MaxAlignment - 1);
  TII.loadImmediate(MBB, MBBI, &Reg, MaxAlignment);
  BuildMI(MBB, MBBI, DL, TII.get(Xtensa::AND)) ... .addReg(FP) ...
  BuildMI(MBB, MBBI, DL, TII.get(Xtensa::SUB), RegMisAlign) ...
  BuildMI(MBB, MBBI, DL, TII.get(Xtensa::ADD), SP).addReg(SP) ...
}
```

`MOVSP` is used only on the large-frame (`StackSize > 32760`) path and for dynamic
alloca or stackrestore (`XtensaISD::MOVSP`). No test covers an over-aligned frame with
`+windowed`.

## Related problems in the same block

1. **The misalignment is computed from FP, not SP.** When the function keeps a frame
   pointer, FP is `a7`. The `AND` reads `a7` before the prologue's `mov.n a7, a1`, and at
   that point `a7` is still an incoming-argument register. The computed realignment is
   arbitrary. Frame pointers are on by default with Espressif clang 22.1.4 at `-O2`, and
   in Rust with `-C force-frame-pointers=yes`:
   ```
   entry   a1, 160
   movi.n  a8, 63
   movi.n  a9, 64
   and     a8, a7, a8        ; a7 not yet set up as FP
   sub     a8, a9, a8
   add.n   a1, a1, a8
   mov.n   a7, a1
   ```
   The code below this block already notes that "FP may be used to pass function
   arguments".
2. **`align 32` is not realigned at all.** The guard is `MaxAlignment > 32`, and SP is
   only 16-byte aligned. An `alloca ..., align 32` therefore gets no realignment
   (`@under_aligned_32` in the reproducer). Please confirm whether this is intended.

## Impact

- Silent corruption of the caller's `a0`–`a3` whenever a window spill lands between
  `entry` and the SP adjustment. On ESP-IDF this happens on any interrupt in that window,
  so the crash is rare, timing-dependent, and shows up in the caller after the
  over-aligned function returns.
- Rust `std::sync::mpsc::{sync_channel, channel}` on all `xtensa-*-espidf` targets is
  affected whenever the instantiating crate uses opt-level `s` or `z`, the usual
  firmware size profile. At opt-level 2 and 3 the constructor is inlined and no
  realignment is emitted.
- With frame pointers enabled, the over-aligned local can also be misaligned, because
  of related problem 1.

## Environment and affected versions

All of these reproduce, on host aarch64-apple-darwin:

| Toolchain | LLVM |
| --- | --- |
| esp-rs Rust 1.88.0.0: `rustc 1.88.0-nightly (2ab28d2e7 2025-06-24) (1.88.0.0)` | 19.1.2 (espressif `xtensa_release_19.1.2`) |
| esp-rs Rust 1.90.0.0 | 20.1.1 |
| esp-rs Rust 1.93.0.0 | 20.1.1 |
| esp-rs Rust 1.97.0.0 | 21.1.3 |
| esp-rs Rust 1.99.0.0 (pre-release) | 22.1.4 |
| Espressif clang/llc esp-19.1.2_20250225 | 19.1.2 |
| Espressif clang/llc esp-22.1.4_20260825 | 22.1.4 |

- Target: `xtensa-esp32s3-espidf` (ESP-IDF v5.5.4), `xtensa-esp32s3-none-elf`, and
  `llc -mtriple=xtensa -mcpu=esp32s3`.
- Upstream `llvm/llvm-project` main has the same code. This was checked in source but
  not executed, because no upstream build with the experimental Xtensa target was
  available.

## References

- Xtensa ISA: MOVSP and the windowed-ABI base save area. MOVSP raises AllocaCause when
  the caller's window is spilled.
  https://dl.espressif.com/github_assets/espressif/xtensa-isa-doc/releases/download/latest/Xtensa.pdf
- ESP-IDF, which spills all windows on interrupt and handles the MOVSP alloca exception:
  - https://github.com/espressif/esp-idf/blob/v5.5.4/components/xtensa/xtensa_context.S
  - https://github.com/espressif/esp-idf/blob/v5.5.4/components/xtensa/xtensa_vectors.S
- Upstream PR that added MOVSP for dynamic alloca: https://github.com/llvm/llvm-project/pull/130001
- GCC's earlier discussion that alloca on Xtensa must adjust SP with `movsp`:
  https://gcc.gnu.org/legacy-ml/gcc/2015-03/msg00139.html

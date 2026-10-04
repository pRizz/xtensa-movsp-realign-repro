# Results

The bug is present in every toolchain tested, from the esp 1.88.0.0 toolchain the
product uses up to the newest esp-rs pre-release (1.99.0.0, LLVM 22.1.4) and Espressif
LLVM esp-22.1.4_20260825. None of them fixes it. The LLVM source code matches this:
the realignment block is unchanged in upstream `llvm/llvm-project` main.

- Run date: 2026-10-04.
- Host: macOS, aarch64-apple-darwin.
- Matrix command: `scripts/matrix.sh`.
- Raw outputs: `out/`. A redacted snapshot is in `evidence/`.

## Version matrix

| esp Rust toolchain | rustc | LLVM | core opt=3 | core opt=z | core opt=3 + frame pointers | std mpsc ctors opt=z (espidf) |
| --- | --- | --- | --- | --- | --- | --- |
| 1.88.0.0 (the product's current toolchain, espup default `esp`) | 1.88.0-nightly (2ab28d2e7 2025-06-24) | 19.1.2 | FAIL | FAIL | FAIL (+ a7 read) | FAIL (`mpmc::sync_channel`, `mpmc::channel`) |
| 1.90.0.0 | 1.90.0-nightly (abf50ae2e 2025-09-16) | 20.1.1 | FAIL | FAIL | FAIL (+ a7 read) | FAIL (both) |
| 1.93.0.0 | 1.93.0-nightly (2b43689c5 2026-01-27) | 20.1.1 | FAIL | FAIL | FAIL (+ a7 read) | FAIL (both) |
| 1.97.0.0 (latest stable esp release) | 1.97.0-nightly (8ea53bcd7 2026-07-08) | 21.1.3 | FAIL | FAIL | FAIL (+ a7 read) | FAIL (both) |
| 1.99.0.0 (pre-release, 2026-09-30) | 1.99.0-nightly (ad02ddc22 2026-09-30) | 22.1.4 | FAIL | FAIL | FAIL (+ a7 read) | not built (see below) |

| Espressif LLVM release | `llc llvm/realign.ll` | `clang c/realign.c` (-O2) |
| --- | --- | --- |
| esp-19.1.2_20250225 | FAIL | FAIL |
| esp-22.1.4_20260825 | FAIL | FAIL (+ a7 read: clang 22 keeps the frame pointer by default) |

In every run, the control functions (with no over-aligned local) show `NO-SP-ADJ`.

The checker classifies each windowed function:

- `FAIL`: `a1` is written by something other than `movsp` after `entry`.
- `+ a7 read`: the realignment `and` reads `a7` (FP) before the prologue sets it.

Per-function details are in [`evidence/matrix.md`](evidence/matrix.md).

### The std reproducer on 1.99.0.0

The 1.99.0.0 pre-release cannot build `std` for `xtensa-esp32s3-espidf` on its own:

```
error[E0425]: cannot find value `AT_FDCWD` in crate `libc` (std/src/sys/fs/unix.rs:1896)
```

That release's `library/Cargo.lock` pins libc 0.2.189. That version defines `AT_FDCWD`
for the newlib vita and rtems targets but not for espidf. This is unrelated to the codegen bug. The core and LLVM-level reproducers
already cover 1.99.0.0 and LLVM 22.1.4.

### Which opt-levels reproduce the std case

On 1.88.0.0, the std constructors realign without `movsp` at opt-level `z` and `s`. The
product firmware crates use `z`, and the generic `sync_channel::<T>` is instantiated in
the calling crate, so it uses that crate's opt-level. At opt-level 2 and 3,
`sync_channel` is inlined into a heap-only path, so there is no over-aligned stack local
and no realignment. The core `align(64)` reproducer fails at every opt-level tried.

## Key assembly

esp 1.88.0.0 at opt-level z: `std::sync::mpmc::sync_channel`, the same symbol and frame
size (`0x1a0`) as in the core dump
([`evidence/esp-1.88.0.0/std-mpsc-Oz.s`](evidence/esp-1.88.0.0/std-mpsc-Oz.s)):

```
_ZN3std4sync4mpmc12sync_channel17h9e3c03da2dc31653E:
	entry	a1, 416
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a1, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8
```

esp 1.99.0.0 at opt-level 3 with `-C force-frame-pointers=yes`. The realignment amount
is computed from `a7` before `mov.n a7, a1`. At that point `a7` is still the sixth
incoming-argument register (the caller's `a15` for `call8`), so its value has nothing
to do with SP:

```
realign_trigger:
	entry	a1, 288
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a7, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8
	mov.n	a7, a1
```

`llc -mtriple=xtensa -mcpu=esp32s3 -O2` on `llvm/realign.ll` gives the same prologue
with both LLVM 19.1.2 and LLVM 22.1.4.

## Source-level confirmation

These were read from source, not executed.

`XtensaFrameLowering::emitPrologue` emits the realignment as
`AND RegMisAlign, FP, MaxAlign-1; SUB RegMisAlign, MaxAlign, RegMisAlign; ADD SP, SP, RegMisAlign`
when `MaxAlignment > 32`. It uses `MOVSP` only for frames larger than 32760 bytes. The
block is the same in all three places checked:

- espressif `xtensa_release_19.1.2` (the LLVM in esp 1.88.0.0):
  https://github.com/espressif/llvm-project/blob/xtensa_release_19.1.2/llvm/lib/Target/Xtensa/XtensaFrameLowering.cpp
- espressif `release/esp_22.x`:
  https://github.com/espressif/llvm-project/blob/release/esp_22.x/llvm/lib/Target/Xtensa/XtensaFrameLowering.cpp
- upstream `llvm/llvm-project` main:
  https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/Xtensa/XtensaFrameLowering.cpp

The same block raises a related question. Because the guard is `MaxAlignment > 32`, an
`align(32)` local gets no realignment at all. That local is then only as aligned as the
16-byte-aligned SP. `llvm/realign.ll` includes `@under_aligned_32` to show this.

## Toolchain provenance

| Toolchain | Source | Install method |
| --- | --- | --- |
| esp 1.88.0.0 | `~/.rustup/toolchains/esp`, installed by espup 0.15.1 | existing; read-only |
| esp 1.90.0.0, 1.93.0.0, 1.97.0.0, 1.99.0.0 | https://github.com/esp-rs/rust-build/releases (`rust-<v>-aarch64-apple-darwin.tar.xz` and `rust-src-<v>.tar.xz`) | `scripts/install-toolchain.sh` into `.toolchains/` |
| Espressif LLVM esp-19.1.2_20250225, esp-22.1.4_20260825 | https://github.com/espressif/llvm-project/releases (`clang-<tag>-aarch64-apple-darwin.tar.xz`) | `scripts/install-llvm.sh` into `.toolchains/` |

`espup install --name/--toolchain-version` was not used. It writes `~/export-esp.sh` and
installs toolchains under the shared rustup home. The tarball route keeps the default
`esp` toolchain and rustup state untouched. `.toolchains/` takes about 11 GB once
unpacked, mostly the full Espressif LLVM packages, and can be deleted at any time.

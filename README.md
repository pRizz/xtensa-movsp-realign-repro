# xtensa-movsp-realign-repro

A standalone reproducer for an Xtensa (ESP32-S3) LLVM code generation bug. You don't
need any hardware to run it.

When a function has a stack local whose alignment is greater than 32, the Xtensa
backend realigns SP after `entry` with plain arithmetic on `a1`:

```
entry   a1, 416
movi.n  a8, 63
movi.n  a9, 64
and     a8, a1, a8
sub     a8, a9, a8
add.n   a1, a1, a8      ; SP moved without movsp
```

Under the windowed ABI, SP must not be moved this way after `entry`. The caller's
`a0`–`a3` base save area lives at `[SP-16]`, and only `movsp` relocates it. If a window
spill happens between `entry` and the `add`, the spill writes that area at the old SP.
ESP-IDF spills all windows on interrupt entry, so this can happen at any time. On
`retw`, the underflow handler then reloads it from the new SP. The caller resumes with
a stale return address, SP and arguments.

On real hardware this crashed in `std::sync::mpmc::sync_channel` and
`std::sync::mpmc::channel`. Those functions own `CachePadded` (`align(64)`) locals.

With frame pointers enabled (the default for Espressif clang 22), the same prologue has
a second problem. It computes the misalignment from FP (`a7`) before `a7` has been set:
`and a8, a7, a8`.

See [RESULTS.md](RESULTS.md) for the version matrix and [ISSUE_DRAFT.md](ISSUE_DRAFT.md)
for the drafted upstream report. The report has not been filed yet.

## Layout

| Path | What it contains |
| --- | --- |
| `src/lib.rs` | `no_std` triggers for `xtensa-esp32s3-none-elf`: an `align(64)` local, a copy of std's `CachePadded` channel shape, and a control function |
| `std-repro/` | The original trigger: `std::sync::mpsc::{sync_channel, channel}` for `xtensa-esp32s3-espidf`. Compiled to an object only, so it needs no ESP-IDF checkout and no linker |
| `llvm/realign.ll` | Toolchain-independent LLVM IR reproducer for `llc` |
| `c/realign.c` | C reproducer for Espressif clang, to show the bug is not specific to Rust |
| `scripts/build.sh` | Builds a Rust variant with one toolchain prefix and emits `.s`, `.ll` and `.o` |
| `scripts/build-llvm.sh` | Runs `llc` and `clang` from one Espressif LLVM release |
| `scripts/check.sh` | Disassembles the output and classifies each windowed function as `FAIL`, `PASS` or `NO-SP-ADJ` (see below) |
| `scripts/install-toolchain.sh` | Installs an esp-rs/rust-build release into `.toolchains/esp-<ver>/` |
| `scripts/install-llvm.sh` | Installs a full Espressif LLVM release (with `llc`) into `.toolchains/` |
| `scripts/matrix.sh` | Runs every variant across all toolchains and writes `out/matrix.md` |
| `scripts/collect-evidence.sh` | Copies the small outputs into `evidence/`, with home paths redacted |
| `tests/test-check.sh` | Tests the checker against hand-written fixtures |
| `evidence/` | Checked-in assembly, IR and matrix output from the run recorded in `RESULTS.md` |

`check.sh` gives each windowed function one of three verdicts:

- `FAIL`: `a1` is written without `movsp`.
- `PASS`: `a1` is only changed with `movsp`.
- `NO-SP-ADJ`: there is no realignment.

## Isolation

Each toolchain is called by its absolute path, as `<prefix>/bin/rustc` and
`<prefix>/bin/cargo`. The scripts never run `rustup toolchain link`, `espup install`
or `export-esp.sh`. Toolchain downloads go to `.toolchains/`, which is gitignored. An
existing `~/.rustup/toolchains/esp` is only read from.

The checker uses the espup-installed `xtensa-esp32s3-elf-objdump` when it can find one,
or the one named in `$OBJDUMP`. Otherwise it falls back to the emitted `.s`. Set
`CHECK_FROM_ASM=1` to force the `.s` path.

## Reproduce

Prerequisites: `just`, `curl`, `tar` with xz support, and bash. You also need one of
these:

- An espup-installed `esp` toolchain with `rust-src`.
- `just install 1.97.0.0`, then `ESP_TOOLCHAIN=$PWD/.toolchains/esp-1.97.0.0`.

```sh
just test                        # checker self-test (fixtures)
just check                       # core reproducer, default esp toolchain, opt-level 3 -> exits 1 (FAIL)
just check z                     # same at opt-level z
just check-std                   # std::sync::mpmc::{sync_channel,channel} at opt-level z -> FAIL
just llvm esp-22.1.4_20260825    # llc on llvm/realign.ll with Espressif LLVM 22.1.4 -> FAIL
just llvm-c esp-22.1.4_20260825  # clang on c/realign.c (shows the a7/FP variant)
just matrix                      # full toolchain matrix -> out/matrix.md
just evidence                    # refresh evidence/
```

You can run the core reproducer without `just` or the scripts:

```sh
cargo +esp rustc --release --target xtensa-esp32s3-none-elf -Zbuild-std=core \
  -- --emit=asm=realign.s
grep -A6 '^realign_trigger:' realign.s
```

You can also run `llc` directly:

```sh
llc -mtriple=xtensa -mcpu=esp32s3 -O2 llvm/realign.ll -o -
```

## License

MIT. See [LICENSE](LICENSE).

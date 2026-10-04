#!/usr/bin/env bash
# Build one reproducer crate with one Xtensa Rust toolchain and emit assembly (and
# LLVM IR for the core crate) plus an object file into out/<label>/<variant>/.
#
# Usage: scripts/build.sh <label> <toolchain-prefix> [opt-level] [core|std]
#   toolchain-prefix  directory containing bin/rustc and bin/cargo, e.g.
#                     ~/.rustup/toolchains/esp or .toolchains/esp-1.97.0.0
#   opt-level         Cargo opt-level (default 3)
#   core              src/lib.rs for xtensa-esp32s3-none-elf, -Zbuild-std=core
#                     -> out/<label>/O<opt>
#   std               std-repro/ (std::sync::mpsc constructors) for xtensa-esp32s3-espidf,
#                     -Zbuild-std=std,panic_abort, object only (no ESP-IDF, no linker)
#                     -> out/<label>/std-O<opt>
# EXTRA_RUSTFLAGS (word-split) is appended to the crate's rustc flags; pair it with a
# distinct <label>, e.g. EXTRA_RUSTFLAGS="-C force-frame-pointers=yes".
set -euo pipefail

main() {
  if [[ $# -lt 2 ]]; then
    echo "usage: $0 <label> <toolchain-prefix> [opt-level] [core|std]" >&2
    exit 2
  fi
  local label="$1" prefix="$2" opt="${3:-3}" kind="${4:-core}"
  local root
  root="$(cd "$(dirname "$0")/.." && pwd)"
  local rustc="$prefix/bin/rustc" cargo="$prefix/bin/cargo"
  [[ -x "$rustc" && -x "$cargo" ]] || { echo "missing rustc/cargo under $prefix" >&2; exit 1; }

  local manifest target build_std variant package emit
  case "$kind" in
    core)
      manifest="$root/Cargo.toml"
      target="xtensa-esp32s3-none-elf"
      build_std="core"
      variant="O$opt"
      package="movsp_realign_repro"
      ;;
    std)
      manifest="$root/std-repro/Cargo.toml"
      target="xtensa-esp32s3-espidf"
      build_std="std,panic_abort"
      variant="std-O$opt"
      package="std_mpmc_repro"
      ;;
    *) echo "unknown crate kind: $kind" >&2; exit 2 ;;
  esac

  local out="$root/out/$label/$variant"
  local target_dir="$root/target/$label/$variant"
  mkdir -p "$out"
  emit="asm=$out/repro.s,obj=$out/repro.o"
  [[ "$kind" == "core" ]] && emit="$emit,llvm-ir=$out/repro.ll"

  # Call the toolchain binaries directly so rustup (and its default `esp` link) is
  # never consulted or modified.
  "$rustc" -vV >"$out/rustc-vV.txt"
  rm -f "$out/repro.s" "$out/repro.ll" "$out/repro.o"
  # Force the crate to recompile so the explicit --emit paths are always rewritten.
  RUSTC="$rustc" "$cargo" clean --manifest-path "$manifest" --target-dir "$target_dir" \
    --release --target "$target" -p "$package" >/dev/null 2>&1
  # shellcheck disable=SC2086 # EXTRA_RUSTFLAGS is intentionally word-split.
  RUSTC="$rustc" CARGO_PROFILE_RELEASE_OPT_LEVEL="$opt" "$cargo" rustc \
    --manifest-path "$manifest" \
    --release \
    --target "$target" \
    "-Zbuild-std=$build_std" \
    --target-dir "$target_dir" \
    -- ${EXTRA_RUSTFLAGS:-} "--emit=$emit"

  echo "$out"
}

main "$@"

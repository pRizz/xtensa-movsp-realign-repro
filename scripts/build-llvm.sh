#!/usr/bin/env bash
# Compile the LLVM IR (llc) and C (clang) reproducers with one Espressif LLVM release
# into out/<label>/llc and out/<label>/clang, in the layout scripts/check.sh expects.
#
# Usage: scripts/build-llvm.sh <label> <esp-clang-dir> [extra clang flags...]
#   esp-clang-dir: the esp-clang directory from scripts/install-llvm.sh.
set -euo pipefail

main() {
  [[ $# -ge 2 ]] || { echo "usage: $0 <label> <esp-clang-dir> [clang flags...]" >&2; exit 2; }
  local label="$1" bin="$2/bin"
  shift 2
  local root
  root="$(cd "$(dirname "$0")/.." && pwd)"
  local llc_out="$root/out/$label/llc" clang_out="$root/out/$label/clang"
  mkdir -p "$llc_out" "$clang_out"

  "$bin/llc" --version | head -3 >"$llc_out/llc-version.txt"
  "$bin/llc" -mtriple=xtensa -mcpu=esp32s3 -O2 "$root/llvm/realign.ll" -o "$llc_out/repro.s"
  "$bin/llc" -mtriple=xtensa -mcpu=esp32s3 -O2 -filetype=obj "$root/llvm/realign.ll" -o "$llc_out/repro.o"

  "$bin/clang" --version | head -1 >"$clang_out/clang-version.txt"
  "$bin/clang" --target=xtensa-esp-elf -mcpu=esp32s3 -O2 "$@" -S "$root/c/realign.c" -o "$clang_out/repro.s"
  "$bin/clang" --target=xtensa-esp-elf -mcpu=esp32s3 -O2 "$@" -c "$root/c/realign.c" -o "$clang_out/repro.o"
  echo "$root/out/$label"
}

main "$@"

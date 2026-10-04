#!/usr/bin/env bash
# Copy the small, reviewable outputs from out/ into evidence/ (checked in), replacing the
# local home directory with "~" so no machine-specific paths are committed.
#
# Usage: scripts/collect-evidence.sh   (run scripts/matrix.sh first)
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
readonly root

copy() {
  local src="$root/out/$1" dest="$root/evidence/$2"
  [[ -s "$src" ]] || { echo "missing $src (run scripts/matrix.sh first)" >&2; exit 1; }
  mkdir -p "$(dirname "$dest")"
  sed "s#$HOME#~#g" "$src" >"$dest"
}

main() {
  rm -rf "$root/evidence"
  copy matrix.md matrix.md
  local label
  for label in esp-1.88.0.0 esp-1.99.0.0; do
    copy "$label/O3/rustc-vV.txt" "$label/rustc-vV.txt"
    copy "$label/O3/repro.s" "$label/core-O3.s"
    copy "$label/O3/repro.ll" "$label/core-O3.ll"
    copy "$label-fp/O3/repro.s" "$label/core-O3-force-frame-pointers.s"
  done
  copy esp-1.88.0.0/std-Oz/repro.s esp-1.88.0.0/std-mpsc-Oz.s
  for label in clang-esp-19.1.2_20250225 clang-esp-22.1.4_20260825; do
    copy "$label/llc/llc-version.txt" "$label/llc-version.txt"
    copy "$label/llc/repro.s" "$label/llc-realign.s"
    copy "$label/clang/clang-version.txt" "$label/clang-version.txt"
    copy "$label/clang/repro.s" "$label/clang-realign.s"
  done
  echo "$root/evidence"
}

main "$@"

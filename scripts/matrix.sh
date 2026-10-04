#!/usr/bin/env bash
# Run every reproducer variant across Xtensa Rust toolchains and Espressif LLVM releases
# and print a Markdown result table (also written to out/matrix.md).
#
# Usage: scripts/matrix.sh
# Environment:
#   RUST_VERSIONS   esp-rs/rust-build versions installed under .toolchains/ by
#                   scripts/install-toolchain.sh (default: 1.90.0.0 1.93.0.0 1.97.0.0 1.99.0.0)
#   LLVM_TAGS       espressif/llvm-project tags installed by scripts/install-llvm.sh
#                   (default: esp-19.1.2_20250225 esp-22.1.4_20260825)
#   SYSTEM_ESP      prefix of the already-installed default toolchain, read-only
#                   (default: ~/.rustup/toolchains/esp; skipped when absent)
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
readonly root
readonly STD_TRIGGERS='mpmc|make_'

rows=()

verdict() {
  local dir="$1" regex="${2:-}" result status=0
  result="$(CHECK_TRIGGER_REGEX="${regex:-realign|cache_padded}" "$root/scripts/check.sh" "$dir" 2>/dev/null)" || status=$?
  if [[ "$status" -gt 1 ]]; then
    echo "CHECK-ERROR | |"
    return 0
  fi
  # Keep the table readable: list FAIL/PASS functions and the controls, with std's
  # mangled mpmc constructor names (legacy or v0 mangling) shortened.
  local summary
  summary="$(grep -E '^(FAIL|PASS) |^NO-SP-ADJ +control' <<<"$result" \
    | awk '{print $1 ":" $2}' \
    | sed -E 's/:.*4mpmc12sync_channel.*/:std::sync::mpmc::sync_channel/; s/:.*4mpmc7channel.*/:std::sync::mpmc::channel/' \
    | sort -u | paste -sd ' ' -)"
  echo "$(tail -1 <<<"$result" | sed -E 's/^RESULT: ([A-Z]+).*/\1/') | $summary"
}

rust_row() {
  local label="$1" prefix="$2"
  local version llvm
  version="$("$prefix/bin/rustc" -vV | sed -n 's/^rustc //p')"
  llvm="$("$prefix/bin/rustc" -vV | sed -n 's/^LLVM version: //p')"

  "$root/scripts/build.sh" "$label" "$prefix" 3 core >/dev/null 2>&1
  rows+=("| $label | $version | $llvm | core, opt-level=3 | $(verdict "$root/out/$label/O3") |")
  "$root/scripts/build.sh" "$label" "$prefix" z core >/dev/null 2>&1
  rows+=("| $label | $version | $llvm | core, opt-level=z | $(verdict "$root/out/$label/Oz") |")
  EXTRA_RUSTFLAGS="-C force-frame-pointers=yes" \
    "$root/scripts/build.sh" "$label-fp" "$prefix" 3 core >/dev/null 2>&1
  rows+=("| $label | $version | $llvm | core, opt-level=3, force-frame-pointers | $(verdict "$root/out/$label-fp/O3") |")
  if "$root/scripts/build.sh" "$label" "$prefix" z std >/dev/null 2>&1; then
    rows+=("| $label | $version | $llvm | std mpsc ctors (espidf), opt-level=z | $(verdict "$root/out/$label/std-Oz" "$STD_TRIGGERS") |")
  else
    rows+=("| $label | $version | $llvm | std mpsc ctors (espidf), opt-level=z | BUILD-ERROR | |")
  fi
}

llvm_row() {
  local tag="$1" dir="$root/.toolchains/clang-$1/esp-clang"
  "$root/scripts/build-llvm.sh" "clang-$tag" "$dir" >/dev/null
  rows+=("| clang-$tag | - | $tag | llc realign.ll | $(verdict "$root/out/clang-$tag/llc") |")
  rows+=("| clang-$tag | - | $tag | clang realign.c | $(verdict "$root/out/clang-$tag/clang") |")
}

main() {
  local system_esp="${SYSTEM_ESP:-$HOME/.rustup/toolchains/esp}" version tag
  if [[ -x "$system_esp/bin/rustc" ]]; then
    rust_row "esp-$("$system_esp/bin/rustc" -vV | sed -n 's/^rustc .*(\([0-9.]*\))$/\1/p')" "$system_esp"
  fi
  for version in ${RUST_VERSIONS:-1.90.0.0 1.93.0.0 1.97.0.0 1.99.0.0}; do
    rust_row "esp-$version" "$("$root/scripts/install-toolchain.sh" "$version" 2>/dev/null)"
  done
  for tag in ${LLVM_TAGS:-esp-19.1.2_20250225 esp-22.1.4_20260825}; do
    "$root/scripts/install-llvm.sh" "$tag" >/dev/null 2>&1
    llvm_row "$tag"
  done

  mkdir -p "$root/out"
  {
    echo "| toolchain | rustc | LLVM | variant | result | per-function verdicts |"
    echo "| --- | --- | --- | --- | --- | --- |"
    printf '%s\n' "${rows[@]}"
  } | tee "$root/out/matrix.md"
}

main "$@"

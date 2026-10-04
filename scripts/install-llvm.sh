#!/usr/bin/env bash
# Download a full Espressif LLVM/Clang release (contains llc, clang, llvm-objdump) and
# unpack it into .toolchains/clang-<tag>/ inside this repo.
#
# Usage: scripts/install-llvm.sh <tag>   (e.g. esp-19.1.2_20250225, esp-22.1.4_20260825)
set -euo pipefail

host_triple() {
  case "$(uname -s)-$(uname -m)" in
    Darwin-arm64) echo "aarch64-apple-darwin" ;;
    Darwin-x86_64) echo "x86_64-apple-darwin" ;;
    Linux-x86_64) echo "x86_64-linux-gnu" ;;
    Linux-aarch64) echo "aarch64-linux-gnu" ;;
    *) echo "unsupported host $(uname -s)-$(uname -m)" >&2; exit 1 ;;
  esac
}

main() {
  [[ $# -eq 1 ]] || { echo "usage: $0 <tag>" >&2; exit 2; }
  local tag="$1" root
  root="$(cd "$(dirname "$0")/.." && pwd)"
  local dest="$root/.toolchains/clang-$tag"
  if [[ -x "$dest/esp-clang/bin/llc" ]]; then
    echo "$dest/esp-clang"
    return 0
  fi
  local host asset dl="$root/.toolchains/dl"
  host="$(host_triple)"
  asset="clang-$tag-$host.tar.xz"
  mkdir -p "$dl" "$dest"
  if [[ ! -s "$dl/$asset" ]]; then
    curl --fail --location --silent --show-error --output "$dl/$asset" \
      "https://github.com/espressif/llvm-project/releases/download/$tag/$asset"
  fi
  tar -xJf "$dl/$asset" -C "$dest"
  "$dest/esp-clang/bin/llc" --version | head -3 >&2
  echo "$dest/esp-clang"
}

main "$@"

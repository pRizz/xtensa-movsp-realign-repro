#!/usr/bin/env bash
# Download an esp-rs/rust-build Xtensa Rust release and install it into
# .toolchains/esp-<version>/ inside this repo. Nothing outside the repo is touched:
# no rustup toolchain link, no ~/export-esp.sh, no change to the default `esp` toolchain.
#
# Usage: scripts/install-toolchain.sh <version>   (e.g. 1.97.0.0)
# Requires: gh (authenticated) or curl, tar with xz support.
set -euo pipefail

host_triple() {
  case "$(uname -s)-$(uname -m)" in
    Darwin-arm64) echo "aarch64-apple-darwin" ;;
    Darwin-x86_64) echo "x86_64-apple-darwin" ;;
    Linux-x86_64) echo "x86_64-unknown-linux-gnu" ;;
    Linux-aarch64) echo "aarch64-unknown-linux-gnu" ;;
    *) echo "unsupported host $(uname -s)-$(uname -m)" >&2; exit 1 ;;
  esac
}

download() {
  local version="$1" asset="$2" dest="$3"
  [[ -s "$dest/$asset" ]] && return 0
  local url="https://github.com/esp-rs/rust-build/releases/download/v$version/$asset"
  curl --fail --location --silent --show-error --output "$dest/$asset" "$url"
}

main() {
  [[ $# -eq 1 ]] || { echo "usage: $0 <version>" >&2; exit 2; }
  local version="$1" host root
  host="$(host_triple)"
  root="$(cd "$(dirname "$0")/.." && pwd)"
  local prefix="$root/.toolchains/esp-$version"
  if [[ -x "$prefix/bin/rustc" ]]; then
    echo "$prefix"
    return 0
  fi

  local dl="$root/.toolchains/dl"
  mkdir -p "$dl"
  local rust_asset="rust-$version-$host.tar.xz" src_asset="rust-src-$version.tar.xz"
  download "$version" "$rust_asset" "$dl"
  download "$version" "$src_asset" "$dl"

  local work
  work="$(mktemp -d "$root/.toolchains/extract.XXXXXX")"
  tar -xJf "$dl/$rust_asset" -C "$work"
  tar -xJf "$dl/$src_asset" -C "$work"
  local installer
  for installer in "$work"/*/install.sh; do
    "$installer" --prefix="$prefix" --disable-ldconfig >/dev/null
  done
  rm -rf "$work"
  "$prefix/bin/rustc" -vV >&2
  echo "$prefix"
}

main "$@"

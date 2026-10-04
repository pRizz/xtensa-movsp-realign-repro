# Xtensa windowed-ABI stack-realignment reproducer. All toolchains used here live in
# .toolchains/ (gitignored) or are read-only uses of an existing ~/.rustup/toolchains/esp.

esp := env_var_or_default("ESP_TOOLCHAIN", env_var("HOME") + "/.rustup/toolchains/esp")

# List recipes.
default:
    @just --list

# Build the core (no_std, no ESP-IDF) reproducer with the default esp toolchain.
build opt="3":
    scripts/build.sh esp-default {{esp}} {{opt}} core

# Build the std::sync::mpsc constructor reproducer (object only, no ESP-IDF needed).
build-std opt="z":
    scripts/build.sh esp-default {{esp}} {{opt}} std

# Check the default-toolchain build: exits 1 when a1 is changed without movsp.
check opt="3": (build opt)
    scripts/check.sh out/esp-default/O{{opt}}

# Check the std mpsc constructors (the original crash site).
check-std opt="z": (build-std opt)
    CHECK_TRIGGER_REGEX='mpmc|make_' scripts/check.sh out/esp-default/std-O{{opt}}

# Install one esp-rs/rust-build release into .toolchains/ (e.g. just install 1.97.0.0).
install version:
    scripts/install-toolchain.sh {{version}}

# Install one Espressif LLVM release with llc/clang into .toolchains/.
install-llvm tag:
    scripts/install-llvm.sh {{tag}}

# Compile realign.ll with llc and realign.c with clang for one Espressif LLVM release.
llvm-build tag="esp-22.1.4_20260825":
    scripts/install-llvm.sh {{tag}}
    scripts/build-llvm.sh clang-{{tag}} .toolchains/clang-{{tag}}/esp-clang

# Check the llc output of llvm/realign.ll (the toolchain-independent reproducer).
llvm tag="esp-22.1.4_20260825": (llvm-build tag)
    scripts/check.sh out/clang-{{tag}}/llc

# Check the clang output of c/realign.c.
llvm-c tag="esp-22.1.4_20260825": (llvm-build tag)
    scripts/check.sh out/clang-{{tag}}/clang

# Full version matrix (downloads ~150 MB per Rust toolchain, ~270 MB per LLVM release).
matrix:
    scripts/matrix.sh

# Refresh the checked-in evidence/ snapshot from out/.
evidence:
    scripts/collect-evidence.sh

# Self-test the checker against hand-written fixtures.
test:
    tests/test-check.sh

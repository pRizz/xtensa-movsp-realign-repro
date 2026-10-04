#!/usr/bin/env bash
# Classify every windowed (`entry`) function in a build output by how it changes a1 (SP)
# after `entry`:
#   FAIL      plain arithmetic/move writes a1 (no movsp) -> windowed-ABI violation
#   PASS      a1 is only changed with movsp
#   NO-SP-ADJ a1 is never changed after entry (no dynamic realignment emitted)
#
# Usage: scripts/check.sh <out-dir>   (a directory produced by scripts/build.sh)
# Disassembles <out-dir>/repro.o with an Xtensa objdump when one is found
# ($OBJDUMP, xtensa-esp32s3-elf-objdump on PATH, or the espup-installed GCC under
# ~/.rustup/toolchains/*/xtensa-esp-elf); otherwise falls back to <out-dir>/repro.s.
# Set CHECK_FROM_ASM=1 to always use repro.s.
# A second note, "reads a7 before it is set", marks the frame-pointer variant of the same
# prologue, where the realignment amount is computed from the not-yet-initialized FP (a7).
# Exit status: 1 if any trigger function is FAIL, 2 on usage/input errors, 0 otherwise.
set -euo pipefail

# Functions whose names match this regex own an over-aligned local and must not FAIL.
readonly TRIGGER_REGEX="${CHECK_TRIGGER_REGEX:-realign|cache_padded}"

find_objdump() {
  if [[ -n "${OBJDUMP:-}" ]]; then echo "$OBJDUMP"; return 0; fi
  if command -v xtensa-esp32s3-elf-objdump >/dev/null; then
    command -v xtensa-esp32s3-elf-objdump
    return 0
  fi
  local candidate
  for candidate in "$HOME"/.rustup/toolchains/*/xtensa-esp-elf/*/xtensa-esp-elf/bin/xtensa-esp32s3-elf-objdump; do
    [[ -x "$candidate" ]] && { echo "$candidate"; return 0; }
  done
  return 1
}

disassemble() {
  local out="$1" objdump
  if [[ "${CHECK_FROM_ASM:-0}" != "1" ]] && objdump="$(find_objdump)"; then
    echo "# source: $objdump -d $out/repro.o" >&2
    "$objdump" -d "$out/repro.o"
    return
  fi
  echo "# source: $out/repro.s (no Xtensa objdump found)" >&2
  cat "$out/repro.s"
}

# Normalizes objdump and assembler listings into "FUNC <name>" / "INSN <mnemonic> <operands>".
normalize() {
  awk '
    /^[0-9a-f]+ <[^>]+>:$/ { name = $2; gsub(/[<>:]/, "", name); print "FUNC " name; next }
    /^[A-Za-z_][A-Za-z0-9_$]*:/ { name = $1; sub(/:.*/, "", name); print "FUNC " name; next }
    /^[ \t]+[0-9a-f]+:\t/ {
      n = split($0, f, "\t"); if (n < 3) next
      print "INSN " f[3] " " f[4]; next
    }
    /^\t[a-z]/ {
      line = $0; sub(/^\t/, "", line)
      if (line ~ /^\./) next
      n = split(line, f, "\t"); print "INSN " f[1] " " f[2]; next
    }
  '
}

classify() {
  awk '
    function flush() {
      if (fn == "" || !windowed) return
      verdict = writes ? "FAIL" : (movsp ? "PASS" : "NO-SP-ADJ")
      printf "%-10s %s%s\n", verdict, fn, (detail != "" ? "  [" detail "]" : "")
    }
    function note(text) { detail = detail (detail ? "; " : "") text }
    $1 == "FUNC" { flush(); fn = $2; windowed = 0; writes = 0; movsp = 0; detail = ""; first = 1; a7set = 0; next }
    $1 == "INSN" {
      mnem = $2; ops = $0; sub(/^INSN [^ ]+ ?/, "", ops); gsub(/ /, "", ops)
      if (first) { windowed = (mnem == "entry"); first = 0; next }
      split(ops, o, ",")
      if (mnem == "and" && !a7set && (o[2] == "a7" || o[3] == "a7")) note("reads a7 before it is set: " mnem " " ops)
      if (o[1] == "a7" && mnem !~ /^s(8|16|32)/ && mnem !~ /^b/) a7set = 1
      if (o[1] != "a1") next
      if (mnem == "movsp") { movsp = 1; note(mnem " " ops); next }
      # First operand is a source for stores and branches, not a destination.
      if (mnem ~ /^s(8|16|32)/ || mnem ~ /^(ssi|ssip|ssx|ssxp|b[a-z]*)$/) next
      writes = 1; note(mnem " " ops)
    }
    END { flush() }
  '
}

main() {
  [[ $# -eq 1 ]] || { echo "usage: $0 <out-dir>" >&2; exit 2; }
  local out="$1" report status=0
  [[ -s "$out/repro.s" ]] || { echo "missing $out/repro.s" >&2; exit 2; }
  if [[ "${CHECK_FROM_ASM:-0}" != "1" && ! -s "$out/repro.o" ]]; then
    echo "missing $out/repro.o" >&2
    exit 2
  fi
  report="$(disassemble "$out" | normalize | classify)"
  echo "$report"
  if ! grep -Eq "^[A-Z-]+ +[^ ]*($TRIGGER_REGEX)" <<<"$report"; then
    echo "no trigger function matching /$TRIGGER_REGEX/ in disassembly" >&2
    exit 2
  fi
  if grep -Eq "^FAIL +[^ ]*($TRIGGER_REGEX)" <<<"$report"; then status=1; fi
  if [[ $status -eq 1 ]]; then
    echo "RESULT: FAIL (a1 rewritten without movsp in a windowed prologue)"
  else
    echo "RESULT: PASS"
  fi
  return "$status"
}

main "$@"

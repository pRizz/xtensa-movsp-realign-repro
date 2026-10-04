#!/usr/bin/env bash
# Self-test for scripts/check.sh against hand-written assembly fixtures.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
failures=0

expect() {
  local fixture="$1" want_exit="$2" want_text="$3" output got_exit=0
  output="$(CHECK_FROM_ASM=1 "$root/scripts/check.sh" "$root/tests/fixtures/$fixture" 2>/dev/null)" || got_exit=$?
  if [[ "$got_exit" -ne "$want_exit" ]] || ! grep -Fq -- "$want_text" <<<"$output"; then
    echo "not ok - $fixture: exit $got_exit (want $want_exit), output:"
    echo "$output"
    failures=$((failures + 1))
    return 0
  fi
  echo "ok - $fixture"
}

expect fail 1 "FAIL       realign_trigger  [add.n a1,a1,a8]"
expect pass 0 "PASS       realign_trigger  [movsp a1,a8]"
expect no-adjust 0 "NO-SP-ADJ  realign_trigger"
expect fp-uninit 1 "reads a7 before it is set: and a8,a7,a8"

[[ "$failures" -eq 0 ]]

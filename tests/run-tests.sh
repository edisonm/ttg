#!/bin/sh
# Smoke/regression tests for the headless solver (`ttgsolve --solve`).
# Usage: run-tests.sh <path to ttgsolve> <examples dir>
set -u

TTGSOLVE=${1:?usage: run-tests.sh <ttgsolve> <examples-dir>}
EXAMPLES=${2:?usage: run-tests.sh <ttgsolve> <examples-dir>}
WORK=$(mktemp -d) || exit 1
trap 'rm -rf "$WORK"' EXIT

fail() { echo "FAIL: $1"; exit 1; }
pass() { echo "ok: $1"; }
solve() { "$TTGSOLVE" --solve --no-downhill "$@" 2>/dev/null; }

"$TTGSOLVE" --help >/dev/null || fail '--help should exit 0'
pass '--help'

IN="$EXAMPLES/Salamanca1999.ttd"
[ -f "$IN" ] || fail "missing $IN"

solve --seed=1234 --max-iterations=20 "$IN" "$WORK/a.ttd" >"$WORK/a.log" \
  || fail 'solve exited nonzero'
grep -q 'Total Value' "$WORK/a.log"     || fail 'no summary in output'
grep -q 'saved to' "$WORK/a.log"        || fail 'no save confirmation'
[ -s "$WORK/a.ttd" ]                    || fail 'output .ttd missing or empty'
grep -q 'SkipDownHill' "$WORK/a.ttd" \
  && fail 'test-only SkipDownHill flag leaked into the saved .ttd'
pass 'solve Salamanca1999 (20 iterations)'

solve --seed=1234 --max-iterations=20 "$IN" "$WORK/b.ttd" >"$WORK/b.log" \
  || fail 'second solve exited nonzero'
# With a fixed seed the same total value must come out of both runs.
va=$(grep 'Total Value' "$WORK/a.log" | awk '{print $NF}')
vb=$(grep 'Total Value' "$WORK/b.log" | awk '{print $NF}')
{ [ -n "$va" ] && [ "$va" = "$vb" ]; } \
  || fail "nondeterministic with fixed seed: $va vs $vb"
pass "deterministic with fixed seed (total value $va)"

# A saved solution must reload and re-solve cleanly (.ttd round trip).
solve --seed=1 --max-iterations=5 "$WORK/a.ttd" "$WORK/c.ttd" \
  >/dev/null || fail 're-solving a solved file failed'
pass 'round trip through saved solution'

echo 'All tests passed'

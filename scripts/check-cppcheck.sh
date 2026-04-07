#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Cppcheck gate for pre-commit and CI.
set -euo pipefail

readonly ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "error: not inside a git repository." >&2
  exit 2
}
cd "$ROOT"

if ! command -v cppcheck >/dev/null 2>&1; then
  echo "error: cppcheck not found on PATH." >&2
  exit 2
fi

if [[ $# -gt 0 ]]; then
  files=("$@")
  total="${#files[@]}"
  index=0
  failed=0
  echo "cppcheck scope: provided files (headers and sources)."
  for f in "${files[@]}"; do
    index=$((index + 1))
    echo "Checking ${f} ..."
    if ! cppcheck --error-exitcode=1 --enable=all --inline-suppr \
      --quiet \
      --suppress=missingIncludeSystem \
      --suppress=checkersReport \
      -I "${ROOT}/include" \
      "${f}"; then
      failed=$((failed + 1))
    fi
    echo "${index}/${total} files checked"
  done
  if [[ "${failed}" -gt 0 ]]; then
    exit 1
  fi
fi

echo "cppcheck scope: full repository via '.' (headers included; build/ excluded)."
exec cppcheck --error-exitcode=1 --enable=all --inline-suppr \
  --suppress=missingIncludeSystem \
  --suppress=checkersReport \
  -I "${ROOT}/include" \
  -i "${ROOT}/build" \
  ./

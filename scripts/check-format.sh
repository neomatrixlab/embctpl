#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Run clang-format in check mode on all tracked C/C++ sources (same scope as GitLab lint:format).
set -euo pipefail

readonly ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "error: not inside a git repository." >&2
  exit 2
}
cd "$ROOT"

if ! command -v clang-format >/dev/null 2>&1; then
  echo "error: clang-format not found on PATH." >&2
  exit 2
fi

if [[ $# -gt 0 ]]; then
  files=("$@")
else
  mapfile -t files < <(git ls-files '*.c' '*.h' '*.cpp' '*.cc' '*.cxx' || true)
fi
if [[ "${#files[@]}" -eq 0 ]]; then
  echo "No tracked C/C++ files."
  exit 0
fi

failed=0
total="${#files[@]}"
index=0

for f in "${files[@]}"; do
  index=$((index + 1))
  echo "Checking ${f} ..."
  if ! clang-format --dry-run --Werror "${f}"; then
    failed=$((failed + 1))
  fi
  echo "${index}/${total} files checked"
done

if [[ "${failed}" -gt 0 ]]; then
  exit 1
fi

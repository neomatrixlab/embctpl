#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# clang-tidy using build/host-debug/compile_commands.json (same behavior as CI lint:tidy).
# Policy: .clang-tidy (WarningsAsErrors, ExcludeHeaderFilterRegex, etc.).
# Usage: check-tidy.sh [file ...]   (default: all tracked *.c *.cpp *.cc *.cxx)
set -euo pipefail

readonly ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "error: not inside a git repository." >&2
  exit 2
}
cd "$ROOT"

readonly COMPILE_DB="${ROOT}/build/host-debug/compile_commands.json"
if [[ ! -f "${COMPILE_DB}" ]]; then
  echo "error: missing ${COMPILE_DB}" >&2
  echo "Run: cmake --preset host-debug --fresh && cmake --build --preset host-debug -j" >&2
  exit 2
fi

if ! command -v clang-tidy >/dev/null 2>&1; then
  echo "error: clang-tidy not found on PATH." >&2
  exit 2
fi

if [[ $# -gt 0 ]]; then
  files=("$@")
else
  mapfile -t files < <(git ls-files '*.c' '*.cpp' '*.cc' '*.cxx' || true)
fi

if [[ "${#files[@]}" -eq 0 ]]; then
  echo "No C/C++ source files to check."
  exit 0
fi

echo "clang-tidy scope: translation units (*.c/*.cpp). Headers are checked through includes."
total="${#files[@]}"
index=0
failed=0

for f in "${files[@]}"; do
  index=$((index + 1))
  echo "Checking ${f} ..."
  output="$(clang-tidy -p "${ROOT}/build/host-debug" -quiet "$f" 2>&1)"
  status=$?
  filtered="$(printf '%s\n' "${output}" | awk '!($0 ~ /^[0-9]+ warnings generated\.$/ || $0 ~ /^Suppressed [0-9]+ warnings/)')"
  if [[ -n "${filtered}" ]]; then
    printf '%s\n' "${filtered}"
  fi
  if [[ "${status}" -ne 0 ]]; then
    failed=$((failed + 1))
  fi
  echo "${index}/${total} files checked"
done

if [[ "${failed}" -gt 0 ]]; then
  exit 1
fi

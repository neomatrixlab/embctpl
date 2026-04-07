#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

readonly MSG_FILE="${1:-}"
if [[ -z "${MSG_FILE}" ]]; then
  echo "usage: verify-commit-msg.sh <commit-msg-file>" >&2
  exit 2
fi

readonly msg="$(tr -d '\r' < "${MSG_FILE}")"

# Allow default merge commits created by git merge.
if [[ "${msg}" =~ ^Merge[[:space:]] ]]; then
  exit 0
fi

# Conventional Commits: type(scope)!?: subject
readonly pattern='^(build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test)(\([[:alnum:]._/-]+\))?(!)?: .+'
if [[ ! "${msg}" =~ ${pattern} ]]; then
  cat <<'ERR' >&2
Commit message does not follow Conventional Commits.

Expected format: type(optional-scope)!: subject

Examples:
  feat: add CRC-8 helper
  fix(core): handle empty input buffer
  chore(ci): update GitLab job image
ERR
  exit 1
fi

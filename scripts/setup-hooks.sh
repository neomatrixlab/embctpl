#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

readonly ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

git config core.hooksPath .githooks
chmod +x .githooks/pre-commit .githooks/commit-msg || true
chmod +x scripts/check-format.sh scripts/check-cppcheck.sh scripts/check-tidy.sh \
  scripts/verify-commit-msg.sh || true

echo "Git hooks path set to .githooks"

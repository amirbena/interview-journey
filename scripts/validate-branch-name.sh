#!/usr/bin/env bash
#
# Validates a Git branch name against the repository convention:
#
#   <type>/<issue-number>-<short-description>
#
# type: feat | fix | refactor | docs | ci | chore | test
# Example: feat/25-plugin-distribution
#
# `main` is exempt. Provider-owned names such as claude/* or codex/* are NOT
# exempt: rename them (git branch -m <new-name>) before the first push.
# Pure string check: it never touches the network or rewrites anything.
# See policies/git-workflow.md.
#
# Usage: validate-branch-name.sh [branch]
#   Defaults to PR_BRANCH, then the current branch.

set -euo pipefail

BRANCH="${1-${PR_BRANCH-}}"
if [ -z "$BRANCH" ]; then
  BRANCH="$(git branch --show-current 2>/dev/null || true)"
fi
[ -n "$BRANCH" ] || { echo "error: no branch name given and no current branch (detached HEAD?)" >&2; exit 1; }

[ "$BRANCH" = "main" ] && exit 0

PATTERN='^(feat|fix|refactor|docs|ci|chore|test)/[0-9]+-[a-z0-9]+(-[a-z0-9]+)*$'
if [[ "$BRANCH" =~ $PATTERN ]]; then
  echo "ok: branch name '${BRANCH}' follows the convention"
  exit 0
fi

cat >&2 <<MSG
error: branch name '${BRANCH}' does not follow the convention.

  Expected: <type>/<issue-number>-<short-description>
  Types:    feat, fix, refactor, docs, ci, chore, test
  Rules:    lowercase kebab-case after the issue number; the issue must exist
  Example:  feat/25-plugin-distribution

Provider-generated names (claude/*, codex/*, ...) are not exempt.
Rename the branch before pushing:  git branch -m <type>/<issue-number>-<short-description>
Details: policies/git-workflow.md
MSG
exit 1

#!/usr/bin/env bash
# Claude Code powerline. Reads session JSON on stdin, prints a single line:
#   <basename>  <branch>  PR #<n>  <model>
#
# PR number is looked up via `gh pr view`, cached per (worktree, branch) for
# 5 minutes at ~/.claude/state/pr-cache/. Cache misses block briefly (~300ms)
# but only once per branch per 5min, so steady-state renders are free.
# PR badge is an OSC 8 hyperlink — Cmd-click opens the PR in browser.

set -u

INPUT="$(cat)"
DIR="$(printf '%s' "$INPUT" | jq -r '.workspace.current_dir')"
RAW_MODEL="$(printf '%s' "$INPUT" | jq -r '.model.display_name')"

MODEL="$(printf '%s' "$RAW_MODEL" \
  | sed -E 's/.*claude-(opus|sonnet|haiku)-([0-9]+)-([0-9]+)(-fast|-max)?.*/\1 \2.\3\4/' \
  | sed 's/^opus/Opus/;s/^sonnet/Sonnet/;s/^haiku/Haiku/' \
  | sed 's/-/ /')"

BRANCH="$(cd "$DIR" 2>/dev/null && git --no-optional-locks branch --show-current 2>/dev/null)"
DIRTY="$(cd "$DIR" 2>/dev/null && git --no-optional-locks status --porcelain 2>/dev/null | wc -l | tr -d ' ')"

ESC=$'\033'
RESET="${ESC}[0m"
BOLD_CYAN="${ESC}[1m${ESC}[36m"
DIM_CYAN="${ESC}[2m${ESC}[36m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
RED="${ESC}[31m"
MAGENTA="${ESC}[35m"

if [ -n "$BRANCH" ]; then
  if [ "$DIRTY" -gt 0 ] 2>/dev/null; then
    GIT_INFO=" ${YELLOW}${BRANCH}${RESET} ${RED}*${DIRTY}${RESET}"
  else
    GIT_INFO=" ${GREEN}${BRANCH}${RESET}"
  fi
else
  GIT_INFO=""
fi

PR_INFO=""
if [ -n "$BRANCH" ] && command -v gh >/dev/null 2>&1; then
  WORKTREE="$(cd "$DIR" 2>/dev/null && git rev-parse --show-toplevel 2>/dev/null)"
  if [ -n "$WORKTREE" ]; then
    CACHE_DIR="$HOME/.claude/state/pr-cache"
    mkdir -p "$CACHE_DIR"
    KEY="$(printf '%s\t%s' "$WORKTREE" "$BRANCH" | shasum -a 1 | awk '{print $1}')"
    CACHE_FILE="$CACHE_DIR/$KEY.json"

    STALE=1
    if [ -r "$CACHE_FILE" ]; then
      AGE=$(( $(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0) ))
      [ "$AGE" -lt 300 ] && STALE=0
    fi

    if [ "$STALE" = "1" ]; then
      if PR_JSON="$(cd "$WORKTREE" && gh pr view --json number,url 2>/dev/null)"; then
        printf '%s' "$PR_JSON" > "$CACHE_FILE"
      else
        printf '{}' > "$CACHE_FILE"
      fi
    fi

    PR_NUM="$(jq -r '.number // empty' "$CACHE_FILE" 2>/dev/null)"
    PR_URL="$(jq -r '.url // empty' "$CACHE_FILE" 2>/dev/null)"
    if [ -n "$PR_NUM" ] && [ -n "$PR_URL" ]; then
      OSC_OPEN="${ESC}]8;;${PR_URL}${ESC}\\"
      OSC_CLOSE="${ESC}]8;;${ESC}\\"
      PR_INFO=" ${MAGENTA}${OSC_OPEN}PR #${PR_NUM}${OSC_CLOSE}${RESET}"
    fi
  fi
fi

printf '%b' "${BOLD_CYAN}$(basename "$DIR")${RESET}${GIT_INFO}${PR_INFO} ${DIM_CYAN}${MODEL}${RESET}"

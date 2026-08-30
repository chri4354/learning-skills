#!/usr/bin/env bash
# Install the study companion for one or more AI coding tools.
#
#   ./install.sh claude              install for Claude Code, into this project
#   ./install.sh claude --global     install for Claude Code, for every project
#   ./install.sh cursor              install for Cursor, into this project
#   ./install.sh codex               install for Codex, into this project
#   ./install.sh all                 install for all three, into this project
#
# "this project" means the directory you run it from, or --target <dir>.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
TOOLS=()
GLOBAL=0
TARGET="$PWD"

while [[ $# -gt 0 ]]; do
  case "$1" in
    claude|cursor|codex) TOOLS+=("$1"); shift ;;
    all) TOOLS=(claude cursor codex); shift ;;
    --global) GLOBAL=1; shift ;;
    --target) TARGET="$2"; shift 2 ;;
    -h|--help) sed -n '2,10p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown argument: $1" >&2; exit 1 ;;
  esac
done

if [[ ${#TOOLS[@]} -eq 0 ]]; then
  echo "usage: ./install.sh [claude|cursor|codex|all] [--global] [--target DIR]" >&2
  exit 1
fi

say() { printf '  %s\n' "$1"; }

# Append to a file without clobbering what the student already had there.
append_block() {
  local from="$1" to="$2" marker="<!-- study-companion:start -->"
  mkdir -p "$(dirname "$to")"
  if [[ -f "$to" ]] && grep -qF "$marker" "$to"; then
    say "already present, skipping: $to"
    return
  fi
  { [[ -f "$to" ]] && printf '\n'; } >> "$to" || true
  { echo "$marker"; cat "$from"; echo "<!-- study-companion:end -->"; } >> "$to"
  say "wrote: $to"
}

for tool in "${TOOLS[@]}"; do
  echo "$tool:"
  case "$tool" in
    claude)
      if [[ $GLOBAL -eq 1 ]]; then base="$HOME/.claude"; md="$HOME/.claude/CLAUDE.md"
      else base="$TARGET/.claude"; md="$TARGET/CLAUDE.md"; fi
      mkdir -p "$base/skills/study-companion"
      cp "$SRC/dist/claude/.claude/skills/study-companion/SKILL.md" "$base/skills/study-companion/SKILL.md"
      cp "$SRC/dist/claude/.claude/skills/study-companion/profile-template.md" "$base/skills/study-companion/profile-template.md"
      say "wrote: $base/skills/study-companion/SKILL.md"
      append_block "$SRC/dist/claude/CLAUDE.md" "$md"
      ;;
    cursor)
      # Cursor discovers Agent Skills from ~/.cursor/skills (global) and
      # .cursor/skills (per project). Rules, which carry the always-on posture,
      # only exist per project - hence the User Rules paste for global coverage.
      if [[ $GLOBAL -eq 1 ]]; then skills="$HOME/.cursor/skills"
      else skills="$TARGET/.cursor/skills"; fi
      mkdir -p "$skills/study-companion"
      cp "$SRC"/dist/cursor/skills/study-companion/* "$skills/study-companion/"
      say "wrote: $skills/study-companion/SKILL.md"

      if [[ $GLOBAL -eq 1 ]]; then
        say ""
        say "The skill is now global. The always-on posture is not: Cursor rules"
        say "are per-project. To get it in every folder, paste this file into"
        say "Cursor Settings > Rules (User Rules), once:"
        say "  $SRC/dist/cursor/user-rules.txt"
      else
        dir="$TARGET/.cursor/rules"
        mkdir -p "$dir"
        cp "$SRC"/dist/cursor/.cursor/rules/study-companion.mdc "$dir/"
        say "wrote: $dir/study-companion.mdc"
      fi
      ;;
    codex)
      if [[ $GLOBAL -eq 1 ]]; then base="$HOME/.codex"; else base="$TARGET"; fi
      mkdir -p "$base/.study-companion"
      cp "$SRC/dist/codex/.study-companion/"* "$base/.study-companion/"
      append_block "$SRC/dist/codex/AGENTS.md" "$base/AGENTS.md"
      say "wrote: $base/.study-companion/teaching-loop.md"
      ;;
  esac
done

mkdir -p "$TARGET/.learning"
if [[ ! -f "$TARGET/.learning/profile.md" ]]; then
  cp "$SRC/templates/profile.md" "$TARGET/.learning/profile.md"
  echo
  echo "created $TARGET/.learning/profile.md - fill in the first two sections."
fi

# If the target is inside a git repo, keep the student's profile and ledger out
# of it. These record what they struggled with; nobody should push that by
# accident to a shared or public coursework repo.
if git -C "$TARGET" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if ! git -C "$TARGET" check-ignore -q .learning 2>/dev/null; then
    root="$(git -C "$TARGET" rev-parse --show-toplevel)"
    rel="${TARGET#"$root"/}"; [[ "$rel" == "$TARGET" ]] && rel=""
    { [[ -s "$root/.gitignore" ]] && printf '\n'; } >> "$root/.gitignore" || true
    {
      echo "# study companion - your own learning data, keep it out of git"
      echo "${rel:+$rel/}.learning/"
    } >> "$root/.gitignore"
    echo
    echo "added .learning/ to $root/.gitignore - your profile and ledger stay private."
  fi
fi

echo
echo "Done. Start a session and ask about something you're stuck on."

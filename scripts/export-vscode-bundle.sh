#!/usr/bin/env bash
# Copy dist/vscode/ into a course folder's root and its project/ folder, so the
# tutor is on whichever of the two a student opens.
# Usage: scripts/export-vscode-bundle.sh ~/path/to/course-folder
set -euo pipefail
cd "$(dirname "$0")/.."
target="${1:?usage: scripts/export-vscode-bundle.sh <course-folder>}"
[ -d dist/vscode ] || { echo "dist/vscode missing: run ./build.sh first" >&2; exit 1; }
[ -d "$target" ] || { echo "no such folder: $target" >&2; exit 1; }

for dest in "$target" "$target/project"; do
  [ -d "$dest" ] || { echo "skipping missing $dest"; continue; }
  # Remove what earlier bundles shipped, so nothing stale is left behind.
  rm -rf "$dest/.github/skills/study-companion"
  rmdir "$dest/.github/skills" 2>/dev/null || true
  rm -rf "$dest/.gemini"; rm -f "$dest/GEMINI.md"   # Gemini fallback dropped
  mkdir -p "$dest/.github/agents" "$dest/.vscode"
  cp dist/vscode/.github/copilot-instructions.md "$dest/.github/"
  cp dist/vscode/.github/agents/tutor.agent.md   "$dest/.github/agents/"
  cp dist/vscode/.vscode/settings.json dist/vscode/.vscode/extensions.json "$dest/.vscode/"
  cp dist/vscode/AGENTS.md "$dest/"
  echo "exported to $dest"
done

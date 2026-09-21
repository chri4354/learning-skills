#!/usr/bin/env bash
# Copy dist/vscode/ into the root of a course folder. The course folder is the
# one folder students open in VS Code, and the one git repository, so the tutor
# setup lives at its root only.
# Usage: scripts/export-vscode-bundle.sh ~/path/to/course-folder
set -euo pipefail
cd "$(dirname "$0")/.."
target="${1:?usage: scripts/export-vscode-bundle.sh <course-folder>}"
[ -d dist/vscode ] || { echo "dist/vscode missing: run ./build.sh first" >&2; exit 1; }
[ -d "$target" ] || { echo "no such folder: $target" >&2; exit 1; }

# Remove what earlier bundles shipped, so nothing stale is left behind.
rm -rf "$target/.github/skills/study-companion"
rmdir "$target/.github/skills" 2>/dev/null || true
rm -rf "$target/.gemini"; rm -f "$target/GEMINI.md"
if [ -d "$target/project" ]; then   # earlier bundles also went into project/
  rm -rf "$target/project/.github" "$target/project/.vscode" "$target/project/.gemini"
  rm -f "$target/project/AGENTS.md" "$target/project/GEMINI.md"
fi

mkdir -p "$target/.github/agents" "$target/.vscode"
cp dist/vscode/.github/copilot-instructions.md "$target/.github/"
cp dist/vscode/.github/agents/tutor.agent.md   "$target/.github/agents/"
cp dist/vscode/.vscode/settings.json dist/vscode/.vscode/extensions.json "$target/.vscode/"
cp dist/vscode/AGENTS.md "$target/"
echo "exported to $target"

#!/usr/bin/env bash
# Install godfile skills into ~/.claude/skills so Claude Code finds them in any project.
# Usage:
#   ./install.sh              # symlink every skill (re-run any time to sync)
#   ./install.sh --uninstall  # remove all godfile-managed links
set -euo pipefail

GODFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${HOME}/.claude/skills"
mkdir -p "$TARGET"

# Remove existing links that point into this repo (handles renames/removals).
for entry in "$TARGET"/*; do
  [ -L "$entry" ] || continue
  case "$(readlink "$entry")" in
    "$GODFILE_DIR"/*) rm "$entry" ;;
  esac
done

if [ "${1:-}" = "--uninstall" ]; then
  echo "godfile skills uninstalled from $TARGET"
  exit 0
fi

count=0
for skill in "$GODFILE_DIR"/*/*/*/SKILL.md; do
  [ -e "$skill" ] || continue
  dir="$(dirname "$skill")"
  name="$(awk -F': *' '/^name:/{print $2; exit}' "$skill")"
  if [ -z "$name" ]; then
    echo "SKIP (no name in frontmatter): ${skill#"$GODFILE_DIR"/}" >&2
    continue
  fi
  dest="$TARGET/$name"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "SKIP (non-godfile skill already at $dest)" >&2
    continue
  fi
  ln -sfn "$dir" "$dest"
  count=$((count + 1))
done

echo "godfile: linked $count skills into $TARGET"

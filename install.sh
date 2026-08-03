#!/usr/bin/env bash
# Install godfile skills into a supported agent's global skill directory.
# Usage:
#   ./install.sh                       # install for Claude Code (backwards compatible)
#   ./install.sh --codex               # install for Codex
#   ./install.sh --all                 # install for Claude Code and Codex
#   ./install.sh --uninstall [target]  # remove godfile-managed links
set -euo pipefail

GODFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
uninstall=false
targets=("${HOME}/.claude/skills")

for arg in "$@"; do
  case "$arg" in
    --codex) targets=("${HOME}/.codex/skills") ;;
    --claude) targets=("${HOME}/.claude/skills") ;;
    --all) targets=("${HOME}/.claude/skills" "${HOME}/.codex/skills") ;;
    --uninstall) uninstall=true ;;
    *) echo "Unknown option: $arg" >&2; exit 2 ;;
  esac
done

# Install or replace the global agent instructions file next to the skill dir.
# Claude Code reads ~/.claude/CLAUDE.md; Codex reads ~/.codex/AGENTS.md.
sync_instructions() {
  local target="$1"
  local dest
  case "$target" in
    */.claude/*) dest="${HOME}/.claude/CLAUDE.md" ;;
    */.codex/*)  dest="${HOME}/.codex/AGENTS.md" ;;
    *) return ;;
  esac
  if [ "$uninstall" = true ]; then
    rm -f "$dest"
    echo "godfile: removed $dest"
  else
    mkdir -p "$(dirname "$dest")"
    cp "$GODFILE_DIR/CLAUDE.md" "$dest"
    echo "godfile: installed $dest"
  fi
}

sync_target() {
  local target="$1"
  local count=0
  mkdir -p "$target"

  # Remove links into this repo first so renames and deleted skills do not leave stale entries.
  for entry in "$target"/*; do
    [ -L "$entry" ] || continue
    case "$(readlink "$entry")" in
      "$GODFILE_DIR"/*) rm "$entry" ;;
    esac
  done

  if [ "$uninstall" = true ]; then
    echo "godfile skills uninstalled from $target"
    return
  fi

  # Only install godfile entrypoints at <track>/<phase>/<skill>/SKILL.md. This deliberately
  # excludes vendored upstream SKILL.md files nested below references/.
  for skill in "$GODFILE_DIR"/*/*/*/SKILL.md; do
    [ -e "$skill" ] || continue
    dir="$(dirname "$skill")"
    name="$(awk -F': *' '/^name:/{print $2; exit}' "$skill")"
    if [ -z "$name" ]; then
      echo "SKIP (no name in frontmatter): ${skill#"$GODFILE_DIR"/}" >&2
      continue
    fi
    dest="$target/$name"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "SKIP (non-godfile skill already at $dest)" >&2
      continue
    fi
    ln -sfn "$dir" "$dest"
    count=$((count + 1))
  done

  echo "godfile: linked $count skills into $target"
}

for target in "${targets[@]}"; do
  sync_target "$target"
  sync_instructions "$target"
done

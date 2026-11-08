#!/usr/bin/env bash
# Install godfile skills into every supported agent's skill directories.
#
# Global installs symlink each skill so re-running this script picks up updates.
# Project installs COPY skills so they can be committed and shared with a team.
# Bundle exports create portable .skill zips for web upload
# (Claude claude.ai Settings, ChatGPT, Copilot web).
#
# Usage:
#   ./install.sh                                # Claude Code global (backwards compatible)
#   ./install.sh --codex                       # Codex global (~/.agents/skills + ~/.codex/skills legacy)
#   ./install.sh --copilot                     # VS Code Copilot global (~/.copilot/skills + ~/.agents/skills)
#   ./install.sh --vscode                      # alias for --copilot
#   ./install.sh --antigravity                 # Antigravity global (~/.gemini/config/skills + ~/.gemini/skills)
#   ./install.sh --gemini                      # alias for --antigravity
#   ./install.sh --opencode                    # opencode global
#   ./install.sh --claude                      # Claude Code global (explicit)
#   ./install.sh --all                         # every agent above, global
#   ./install.sh --all --project               # every agent, project-local copies in .
#   ./install.sh --project [dir]               # project-local copies only (default dir: .)
#   ./install.sh --project --codex --copilot   # project-local copies for selected agents
#   ./install.sh --global --project --all      # both global links and project copies
#   ./install.sh --bundle [dir]                # export portable .skill zips (default: ./dist)
#   ./install.sh --list [--all]                # show resolved targets without changing anything
#   ./install.sh --all-users --opencode        # opencode for root and every /home user (run as root)
#   ./install.sh --home /root --opencode       # opencode for one specific user's home
#   ./install.sh --uninstall [kinds...]        # remove godfile-managed links/copies
#
# Official skill locations (verified against vendor docs):
#   Claude Code : ~/.claude/skills                     project: .claude/skills
#   Codex       : ~/.agents/skills (current)           project: .agents/skills
#                 ~/.codex/skills (legacy, also linked for compat)
#   Copilot/VS Code: ~/.copilot/skills (personal)      project: .github/skills
#                 Local harness also reads .claude/skills and .agents/skills,
#                 so project installs cover those too.
#   Antigravity : ~/.gemini/config/skills (global)     project: .agents/skills
#                 ~/.gemini/skills (CLI compat, also linked)
#   opencode    : ~/.config/opencode/skills            project: .opencode/skills
set -euo pipefail

GODFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
uninstall=false
all_users=false
do_global=false
do_project=false
do_bundle=false
force=false
list_only=false
kinds=()
homes=()
project_dirs=()
bundle_dir=""

usage() {
  awk '/^set -euo/{exit} {print}' "$0" | tail -n +2 | sed 's/^# \{0,1\}//'
}

while [ $# -gt 0 ]; do
  case "$1" in
    --opencode) kinds+=("opencode") ;;
    --codex) kinds+=("codex") ;;
    --claude) kinds+=("claude") ;;
    --copilot|--vscode) kinds+=("copilot") ;;
    --antigravity|--gemini) kinds+=("antigravity") ;;
    --all) kinds=("claude" "codex" "copilot" "antigravity" "opencode") ;;
    --global) do_global=true ;;
    --project)
      do_project=true
      if [ "${2:-}" != "" ] && [[ "${2:-}" != --* ]]; then
        project_dirs+=("$2")
        shift
      fi
      ;;
    --project=*) do_project=true; project_dirs+=("${1#--project=}") ;;
    --bundle)
      do_bundle=true
      if [ "${2:-}" != "" ] && [[ "${2:-}" != --* ]]; then
        bundle_dir="$2"
        shift
      fi
      ;;
    --bundle=*) do_bundle=true; bundle_dir="${1#--bundle=}" ;;
    --force|-f) force=true ;;
    --list) list_only=true ;;
    --home)
      shift
      [ $# -gt 0 ] || { echo "Missing value for --home" >&2; exit 2; }
      homes+=("$1")
      ;;
    --home=*) homes+=("${1#--home=}") ;;
    --all-users) all_users=true ;;
    --uninstall) uninstall=true ;;
    -h|--help|help) usage; exit 0 ;;
    *) echo "Unknown option: $1 (see --help)" >&2; exit 2 ;;
  esac
  shift
done

# Backwards compatibility: no mode flags means global install.
if [ "$do_global" = false ] && [ "$do_project" = false ] && [ "$do_bundle" = false ] \
   && [ "$list_only" = false ] && [ "$uninstall" = false ]; then
  do_global=true
fi
# --project/--bundle imply their mode when kinds were given without --global.
if [ "$do_project" = true ] && [ "$do_global" = false ] && [ "$do_bundle" = false ] \
   && [ "$uninstall" = false ] && [ "$list_only" = false ]; then
  : # project-only: skip global unless --global also passed
else
  if [ "$do_project" = false ] && [ "$do_bundle" = false ] && [ "$list_only" = false ]; then
    do_global=true
  fi
fi
# --uninstall without --project removes global links (legacy behaviour).
# --uninstall --project removes project copies.
if [ "$uninstall" = true ] && [ "$do_project" = false ] && [ "$do_bundle" = false ]; then
  do_global=true
fi
# --list defaults to showing global targets; add --project/--bundle to include those.
if [ "$list_only" = true ] && [ "$do_project" = false ] && [ "$do_bundle" = false ] \
   && [ "$do_global" = false ]; then
  do_global=true
fi

# Default kinds: global-only legacy default is Claude (backwards compatible).
# Project-only default is every agent, so one command wires the whole repo.
if [ "${#kinds[@]}" -eq 0 ]; then
  if [ "$do_project" = true ] && [ "$do_global" = false ]; then
    kinds=("claude" "codex" "copilot" "antigravity" "opencode")
  else
    kinds=("claude")
  fi
fi

if [ "${#homes[@]}" -eq 0 ]; then
  homes=("${HOME}")
fi

if [ "$all_users" = true ]; then
  homes+=("/root")
  for h in /home/*; do
    [ -d "$h" ] && homes+=("$h")
  done
fi

if [ "$do_project" = true ] && [ "${#project_dirs[@]}" -eq 0 ]; then
  project_dirs=(".")
fi

if [ "$do_bundle" = true ] && [ -z "$bundle_dir" ]; then
  bundle_dir="$GODFILE_DIR/dist"
fi

# De-duplicate while preserving order.
dedupe() {
  local -n _in=$1
  local -n _out=$2
  _out=()
  local _x _y _found
  for _x in ${_in[@]+"${_in[@]}"}; do
    _found=false
    for _y in ${_out[@]+"${_out[@]}"}; do
      [ "$_y" = "$_x" ] && { _found=true; break; }
    done
    [ "$_found" = false ] && _out+=("$_x")
  done
}
unique_homes=(); dedupe homes unique_homes
unique_projects=(); dedupe project_dirs unique_projects
unique_kinds=(); dedupe kinds unique_kinds

# Collect every godfile skill once: "name|dir".
collect_skills() {
  local skill dir name
  for skill in "$GODFILE_DIR"/*/*/*/SKILL.md; do
    [ -e "$skill" ] || continue
    dir="$(dirname "$skill")"
    name="$(awk -F': *' '/^name:/{sub(/\r$/, "", $2); print $2; exit}' "$skill")"
    if [ -z "$name" ]; then
      echo "SKIP (no name in frontmatter): ${skill#"$GODFILE_DIR"/}" >&2
      continue
    fi
    printf '%s|%s\n' "$name" "$dir"
  done
}

# Global skill dirs for one kind + home (may be several for compat paths).
global_dirs_for() {
  case "$1" in
    claude)     echo "$2/.claude/skills" ;;
    codex)      echo "$2/.agents/skills"; echo "$2/.codex/skills" ;;
    copilot)    echo "$2/.copilot/skills"; echo "$2/.agents/skills" ;;
    antigravity) echo "$2/.gemini/config/skills"; echo "$2/.gemini/skills" ;;
    opencode)   echo "$2/.config/opencode/skills" ;;
  esac
}

# Project skill dirs for one kind + project root (copies, committable).
project_dirs_for() {
  local proj="${2%/}"
  case "$1" in
    claude)     echo "$proj/.claude/skills" ;;
    codex)      echo "$proj/.agents/skills" ;;
    copilot)    echo "$proj/.github/skills"; echo "$proj/.agents/skills" ;;
    antigravity) echo "$proj/.agents/skills" ;;
    opencode)   echo "$proj/.opencode/skills" ;;
  esac
}

sync_global_target() {
  local target="$1"
  local count=0
  mkdir -p "$target"

  # Remove links into this repo first so renames/deleted skills leave nothing stale.
  for entry in "$target"/*; do
    [ -L "$entry" ] || continue
    case "$(readlink "$entry")" in
      "$GODFILE_DIR"/*) rm "$entry" ;;
    esac
  done

  if [ "$uninstall" = true ]; then
    echo "godfile: uninstalled skills from $target"
    return 0
  fi

  while IFS='|' read -r name dir; do
    [ -n "$name" ] || continue
    dest="$target/$name"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "SKIP (non-godfile skill already at $dest)" >&2
      continue
    fi
    ln -sfn "$dir" "$dest"
    count=$((count + 1))
  done < <(collect_skills)

  echo "godfile: linked $count skills into $target"
}

sync_project_target() {
  local target="$1"
  local count=0
  mkdir -p "$target"

  # Skill names we manage, for stale-copy cleanup.
  managed="$(collect_skills | cut -d'|' -f1)"

  if [ "$uninstall" = true ]; then
    while IFS= read -r name; do
      [ -n "$name" ] || continue
      if [ -d "$target/$name" ]; then
        rm -rf "$target/$name"
        echo "godfile: removed $target/$name"
      fi
    done <<< "$managed"
    return 0
  fi

  # Remove stale copies of managed skills before re-copying.
  while IFS= read -r name; do
    [ -n "$name" ] || continue
    if [ -e "$target/$name" ] && [ ! -L "$target/$name" ]; then
      rm -rf "$target/$name"
    elif [ -L "$target/$name" ]; then
      rm "$target/$name" # a global-style link has no business inside a committable dir
    fi
  done <<< "$managed"

  while IFS='|' read -r name dir; do
    [ -n "$name" ] || continue
    if [ -e "$target/$name" ]; then
      echo "SKIP (unmanaged entry already at $target/$name)" >&2
      continue
    fi
    cp -r "$dir" "$target/$name"
    printf '%s\n' "$dir" > "$target/$name/.godfile-source"
    count=$((count + 1))
  done < <(collect_skills)

  echo "godfile: copied $count skills into $target"
}

# Install or replace the global agent instructions file(s) for one home.
# Claude Code reads ~/.claude/CLAUDE.md; Codex/opencode/Copilot read AGENTS.md;
# Antigravity reads AGENTS.md (and GEMINI.md, kept identical).
sync_global_instructions() {
  local home="$1"; shift
  local kind dest
  for kind in "$@"; do
    case "$kind" in
      claude)
        dest="$home/.claude/CLAUDE.md"
        if [ "$uninstall" = true ]; then rm -f "$dest"; echo "godfile: removed $dest"
        else mkdir -p "$(dirname "$dest")"; cp "$GODFILE_DIR/CLAUDE.md" "$dest"; echo "godfile: installed $dest"; fi
        ;;
      codex)
        for dest in "$home/.codex/AGENTS.md" "$home/.agents/AGENTS.md"; do
          if [ "$uninstall" = true ]; then rm -f "$dest"; echo "godfile: removed $dest"
          else mkdir -p "$(dirname "$dest")"; cp "$GODFILE_DIR/AGENTS.md" "$dest"; echo "godfile: installed $dest"; fi
        done
        ;;
      copilot)
        dest="$home/.copilot/AGENTS.md"
        if [ "$uninstall" = true ]; then rm -f "$dest"; echo "godfile: removed $dest"
        else mkdir -p "$(dirname "$dest")"; cp "$GODFILE_DIR/AGENTS.md" "$dest"; echo "godfile: installed $dest"; fi
        ;;
      antigravity)
        for dest in "$home/.gemini/config/AGENTS.md" "$home/.gemini/AGENTS.md" \
                    "$home/.gemini/config/GEMINI.md" "$home/.gemini/GEMINI.md"; do
          if [ "$uninstall" = true ]; then rm -f "$dest"; echo "godfile: removed $dest"
          else mkdir -p "$(dirname "$dest")"; cp "$GODFILE_DIR/AGENTS.md" "$dest"; echo "godfile: installed $dest"; fi
        done
        ;;
      opencode)
        dest="$home/.config/opencode/AGENTS.md"
        if [ "$uninstall" = true ]; then rm -f "$dest"; echo "godfile: removed $dest"
        else mkdir -p "$(dirname "$dest")"; cp "$GODFILE_DIR/AGENTS.md" "$dest"; echo "godfile: installed $dest"; fi
        ;;
    esac
  done
}

# Project instruction files: copy only when missing, unless --force.
# AGENTS.md is read by Codex, Copilot, Claude Code (>=2.1.277) and Antigravity;
# CLAUDE.md by Claude Code; copilot-instructions.md by VS Code; GEMINI.md by Gemini/Antigravity.
sync_project_instructions() {
  local proj="${1%/}"
  put() {
    local src="$GODFILE_DIR/$1" dest="$proj/$2"
    if [ "$uninstall" = true ]; then
      # Only remove files we installed (identical copy); never delete user edits.
      if [ -f "$dest" ] && cmp -s "$src" "$dest"; then rm -f "$dest"; echo "godfile: removed $dest"; fi
      return 0
    fi
    if [ -f "$dest" ] && [ "$force" = false ]; then
      echo "godfile: kept existing $dest (use --force to overwrite)"
      return 0
    fi
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "godfile: installed $dest"
  }
  put "CLAUDE.md" "CLAUDE.md"
  put "AGENTS.md" "AGENTS.md"
  put "AGENTS.md" "GEMINI.md"
  put "AGENTS.md" ".github/copilot-instructions.md"
}

export_bundle() {
  local out="$1"
  mkdir -p "$out"
  local backend=""
  if command -v zip >/dev/null 2>&1; then
    backend="zip"
  elif command -v python3 >/dev/null 2>&1; then
    backend="python3"
  else
    echo "godfile: need 'zip' or 'python3' to build bundles for $out" >&2
    return 1
  fi
  local count=0
  while IFS='|' read -r name dir; do
    [ -n "$name" ] || continue
    rm -f "$out/$name.skill"
    if [ "$backend" = "zip" ]; then
      (cd "$dir" && zip -qr "$out/$name.skill" . -x '.godfile-source')
    else
      python3 - "$dir" "$out/$name.skill" <<'EOF'
import sys, os, zipfile
src, dest = sys.argv[1], sys.argv[2]
with zipfile.ZipFile(dest, 'w', zipfile.ZIP_DEFLATED) as z:
    for root, _, files in os.walk(src):
        for f in files:
            if f == '.godfile-source':
                continue
            p = os.path.join(root, f)
            z.write(p, os.path.relpath(p, src))
EOF
    fi
    count=$((count + 1))
  done < <(collect_skills)
  cat > "$out/README.txt" <<EOF
godfile skill bundle ($(date -u +%Y-%m-%d)).
Each <name>.skill is a zip of one skill folder: upload it via
Claude (claude.ai Settings > Skills), ChatGPT, or Copilot web,
or unzip it into any agent skills directory.
Source: https://github.com/blackprince001/skills
EOF
  echo "godfile: bundled $count skills into $out (+ README.txt)"
}

if [ "$list_only" = true ]; then
  if [ "$do_global" = true ]; then
    all_targets=()
    for home in ${unique_homes[@]+"${unique_homes[@]}"}; do
      for kind in ${unique_kinds[@]+"${unique_kinds[@]}"}; do
        while IFS= read -r t; do all_targets+=("$t"); done < <(global_dirs_for "$kind" "$home")
      done
    done
    seen=(); dedupe all_targets seen
    printf '%s\n' ${seen[@]+"${seen[@]}"}
  fi
  if [ "$do_project" = true ]; then
    all_targets=()
    for proj in ${unique_projects[@]+"${unique_projects[@]}"}; do
      for kind in ${unique_kinds[@]+"${unique_kinds[@]}"}; do
        while IFS= read -r t; do all_targets+=("$t"); done < <(project_dirs_for "$kind" "$proj")
      done
      all_targets+=("$proj/CLAUDE.md" "$proj/AGENTS.md" "$proj/GEMINI.md" "$proj/.github/copilot-instructions.md")
    done
    seen=(); dedupe all_targets seen
    printf '%s\n' ${seen[@]+"${seen[@]}"}
  fi
  if [ "$do_bundle" = true ]; then
    echo "$bundle_dir/<skill-name>.skill"
  fi
  exit 0
fi

if [ "$do_global" = true ]; then
  for home in ${unique_homes[@]+"${unique_homes[@]}"}; do
    # Resolve every target dir first so shared dirs (e.g. ~/.agents/skills)
    # are synced once even when two kinds map to them.
    targets=()
    for kind in ${unique_kinds[@]+"${unique_kinds[@]}"}; do
      while IFS= read -r t; do targets+=("$t"); done < <(global_dirs_for "$kind" "$home")
    done
    seen=(); dedupe targets seen
    for target in ${seen[@]+"${seen[@]}"}; do
      if ! sync_global_target "$target"; then
        echo "godfile: failed for $target (run as root for other users)" >&2
        continue
      fi
    done
    # shellcheck disable=SC2068
    sync_global_instructions "$home" ${unique_kinds[@]} || echo "godfile: failed to install instructions for $home" >&2
  done
fi

if [ "$do_project" = true ]; then
  for proj in ${unique_projects[@]+"${unique_projects[@]}"}; do
    targets=()
    for kind in ${unique_kinds[@]+"${unique_kinds[@]}"}; do
      while IFS= read -r t; do targets+=("$t"); done < <(project_dirs_for "$kind" "$proj")
    done
    seen=(); dedupe targets seen
    for target in ${seen[@]+"${seen[@]}"}; do
      sync_project_target "$target" || echo "godfile: failed for $target" >&2
    done
    sync_project_instructions "$proj"
  done
fi

if [ "$do_bundle" = true ]; then
  if [ "$uninstall" = true ]; then
    echo "godfile: --uninstall does not remove bundles in $bundle_dir (delete manually)"
  else
    export_bundle "$bundle_dir"
  fi
fi

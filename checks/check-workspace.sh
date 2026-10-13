#!/usr/bin/env bash
# check-workspace.sh: read-only structure check of an agent workspace against the Agentic Work Playbook.
# Usage: bash check-workspace.sh [workspace-folder]   (default: the current folder)
# It never creates, changes or deletes a file, never uses the network, never runs Git, and never prints a secret value.
# Exit code: 0 when every required check passes (warnings allowed), 1 when something must be fixed, 2 when the folder cannot be read.
# Needs only bash 3.2 or newer and standard tools: find, grep, awk, sed, wc, head, sort, tr.

set -u
LC_ALL=C
export LC_ALL
shopt -s nullglob

nl='
'
script_dir=$(cd "$(dirname "$0")" && pwd)
guide_version="unknown"
if [ -f "$script_dir/../VERSION" ]; then
  guide_version=$(head -n 1 "$script_dir/../VERSION" | tr -d '[:space:]')
fi

case "${1:-}" in
  -h|--help)
    printf '%s\n' \
      "Usage: bash check-workspace.sh [workspace-folder]" \
      "Checks a workspace's structure against the Agentic Work Playbook. Read-only: it changes nothing." \
      "Exit code 0: every required check passes. 1: something must be fixed. 2: the folder cannot be read."
    exit 0
    ;;
esac

target="${1:-.}"
if [ ! -d "$target" ] || ! cd "$target" 2>/dev/null; then
  printf 'Cannot open the folder: %s\n' "$target" >&2
  exit 2
fi
workspace=$(pwd)

passes=0
fixes=0
warns=0
pass() { passes=$((passes + 1)); printf '  PASS  %s\n' "$1"; }
fix() { fixes=$((fixes + 1)); printf '  FIX   %s\n' "$1"; }
warn() { warns=$((warns + 1)); printf '  WARN  %s\n' "$1"; }
note() { printf '  NOTE  %s\n' "$1"; }
section() { printf '\n%s\n' "$1"; }

# Print a newline-separated list, indented, at most 10 lines.
show_list() {
  total=$(printf '%s\n' "$1" | grep -c .)
  printf '%s\n' "$1" | grep . | head -n 10 | while IFS= read -r item; do printf '        %s\n' "$item"; done
  if [ "$total" -gt 10 ]; then printf '        and %d more\n' $((total - 10)); fi
}

in_list() {
  case " $2 " in *" $1 "*) return 0 ;; esac
  return 1
}

# Boot file names are capitals, digits, hyphens or underscores, ending in .md.
is_boot_name() {
  case "$1" in *.md) ;; *) return 1 ;; esac
  base=${1%.md}
  case "$base" in ''|[!A-Z0-9]*|*[!A-Z0-9_-]*) return 1 ;; esac
  return 0
}

# Folder names are lowercase words joined by hyphens.
is_slug() {
  case "$1" in ''|[!a-z0-9]*|*[!a-z0-9-]*) return 1 ;; esac
  return 0
}

file_size() { wc -c < "$1" | tr -d '[:space:]'; }

# True when a SKILL.md starts with frontmatter holding a name and a description.
has_frontmatter() {
  awk '
    { sub(/\r$/, "") }
    NR == 1 { if ($0 != "---") { bad = 1; exit } ; next }
    $0 == "---" { closed = 1; exit }
    /^name:[ \t]*[^ \t]/ { n = 1 }
    /^description:[ \t]*[^ \t]/ { d = 1 }
    END { exit (bad || !closed || !n || !d) ? 1 : 0 }
  ' "$1"
}

printf 'Workspace check: %s\n' "$workspace"
printf 'Guide version %s. Read-only: this check changes nothing and never shows a secret value.\n' "$guide_version"
printf 'Paths such as docs/boot-files.md are pages of the guide.\n'

# ---------------------------------------------------------------- boot files
section "Boot files (every Markdown file at the top, read at every turn)"
required_boot="WORKSPACE.md OPERATING-MODE.md COMMUNICATION.md SOUL.md IDENTITY.md USER.md RULES.md TOOLS.md MEMORY.md SKILLS.md"
engine_files="CLAUDE.md AGENTS.md"
for name in $required_boot; do
  if [ ! -f "$name" ]; then
    fix "$name is missing. Create it from templates/root/$name (see docs/boot-files.md)."
  elif [ ! -s "$name" ]; then
    fix "$name is empty. Fill it from templates/root/$name (see docs/boot-files.md)."
  else
    pass "$name"
  fi
done
engines=""
for name in $engine_files; do
  if [ -f "$name" ]; then engines="$engines $name"; fi
done
if [ -n "$engines" ]; then
  pass "engine file:$engines"
else
  fix "No engine file. Add CLAUDE.md for Claude Code or AGENTS.md for Codex (see docs/boot-files.md and adapters/)."
fi

extras=""
misnamed=0
boot_count=0
boot_bytes=0
for path in *.md; do
  [ -f "$path" ] || continue
  boot_count=$((boot_count + 1))
  size=$(file_size "$path")
  boot_bytes=$((boot_bytes + size))
  if ! is_boot_name "$path"; then
    misnamed=$((misnamed + 1))
    fix "$path is at the top, so it is read at every turn, but it is not named like a boot file. Move it to its home (docs/workspace.md), or rename it in capitals if it must be read at every turn."
  elif ! in_list "$path" "$required_boot $engine_files"; then
    extras="$extras $path"
  fi
  if [ "$size" -gt 262144 ]; then
    fix "$path is larger than 256 KB, so Agent Bridges leaves it out. Shorten it and move detail into a skill or a space."
  fi
done
if [ -n "$extras" ]; then note "extra boot files, also read at every turn:$extras"; fi
if [ -f AGENTS.md ] && [ "$(file_size AGENTS.md)" -gt 32768 ]; then
  warn "AGENTS.md is larger than 32 KB. Codex without Agent Bridges stops reading project instructions at 32 KB (see adapters/codex.md)."
fi
note "$boot_count boot files, about $(( (boot_bytes + 1023) / 1024 )) KB in total."

# ---------------------------------------------------------------- top of the workspace
section "Top of the workspace (boot files only)"
stray=0
for path in *; do
  [ -d "$path" ] && continue
  case "$path" in *.md) continue ;; esac
  stray=$((stray + 1))
  fix "$path does not belong at the top, which holds boot files only. Move it to its home (docs/workspace.md)."
done
if [ "$stray" -eq 0 ] && [ "$misnamed" -eq 0 ]; then pass "only boot files at the top"; fi

# ---------------------------------------------------------------- folders
section "Folders"
required_dirs="spaces projects resources skills memory archives"
optional_dirs="repositories dashboards"
for d in $required_dirs; do
  if [ -d "$d" ]; then pass "$d/"; else fix "$d/ is missing. Create it (see docs/workspace.md)."; fi
done
absent=""
for d in $optional_dirs; do
  if [ -d "$d" ]; then pass "$d/ (optional)"; else absent="$absent $d/"; fi
done
if [ -n "$absent" ]; then note "not present:$absent. Add them only for code you own and apps you run."; fi
for path in */; do
  name=${path%/}
  in_list "$name" "$required_dirs $optional_dirs" && continue
  warn "$name/ is not part of the workspace structure. Move its content to its home, or ask your person where it belongs (docs/workspace.md)."
done

# Check every folder inside a parent: name, required files, loose files.
# $1 parent, $2 files each folder needs, $3 hint for a missing file, $4 files allowed loose in the parent
check_children() {
  parent=$1
  needed=$2
  hint=$3
  allowed=$4
  [ -d "$parent" ] || return 0
  ok=0
  total=0
  loose=""
  for path in "$parent"/*; do
    name=${path##*/}
    if [ ! -d "$path" ]; then
      in_list "$name" "$allowed" || loose="${loose:+$loose$nl}$path"
      continue
    fi
    case "$name" in _*) note "$path/ skipped (a template folder)"; continue ;; esac
    total=$((total + 1))
    is_slug "$name" || warn "$path/: folder names are lowercase words joined by hyphens (docs/workspace.md)."
    missing=""
    for file in $needed; do
      [ -f "$path/$file" ] || missing="$missing $file"
    done
    if [ -n "$missing" ]; then
      fix "$path/ is missing:$missing. $hint"
    else
      ok=$((ok + 1))
    fi
  done
  if [ "$total" -eq 0 ]; then
    note "$parent/ has no folder yet."
  elif [ "$ok" -eq "$total" ]; then
    pass "$parent/: every folder has $(printf '%s' "$needed" | sed 's/ /, /g') ($total)"
  fi
  if [ -n "$loose" ]; then
    warn "loose files in $parent/, outside any folder. Move each into its folder (docs/workspace.md):"
    show_list "$loose"
  fi
}

section "Spaces, projects and resources"
check_children spaces "INDEX.md" "Start from templates/space/ (docs/workspace.md)." "INDEX.md"
if [ -d spaces ]; then
  slim=0
  for path in spaces/*/; do
    case "${path%/}" in spaces/_*) continue ;; esac
    if [ ! -f "${path}MEMORY.MD" ] || [ ! -f "${path}ROADMAP.md" ]; then slim=$((slim + 1)); fi
  done
  if [ "$slim" -gt 0 ]; then note "$slim spaces keep no MEMORY.MD or ROADMAP.md: fine for a specialist that keeps current facts only."; fi
fi
check_children projects "README.md STATE.md LOGS.md" "Start from templates/project/ (docs/workspace.md)." "INDEX.md"
check_children resources "INDEX.md" "Start from templates/resources/INDEX.md (docs/workspace.md)." "INDEX.md"

# ---------------------------------------------------------------- repositories and dashboards
if [ -d repositories ] || [ -d dashboards ]; then
  section "Repositories and dashboards"
fi
if [ -d repositories ]; then
  repos=0
  unlisted=""
  for path in repositories/*/; do
    name=${path%/}
    name=${name##*/}
    repos=$((repos + 1))
    if [ -f repositories/INDEX.md ] && ! grep -Fq -- "$name" repositories/INDEX.md; then
      unlisted="${unlisted:+$unlisted$nl}repositories/$name/"
    fi
  done
  if [ "$repos" -eq 0 ]; then
    note "repositories/ has no repository yet."
  elif [ ! -f repositories/INDEX.md ]; then
    fix "repositories/INDEX.md is missing. Give each repository one entry there: remote, owner, what it holds, where it runs (docs/workspace.md)."
  elif [ -z "$unlisted" ]; then
    pass "repositories/INDEX.md names every repository ($repos)"
  else
    warn "repositories/INDEX.md does not name these repositories:"
    show_list "$unlisted"
  fi
fi
check_children dashboards "README.md" "Each dashboard record is a README.md (docs/workspace.md)." "INDEX.md"

# ---------------------------------------------------------------- skills
section "Skills"
if [ -d skills ]; then
  total=0
  ok=0
  unlisted=""
  for path in skills/*/; do
    name=${path%/}
    name=${name##*/}
    case "$name" in _*) continue ;; esac
    total=$((total + 1))
    is_slug "$name" || warn "skills/$name/: skill names are lowercase words joined by hyphens (docs/skills.md)."
    if [ ! -f "skills/$name/SKILL.md" ]; then
      fix "skills/$name/ has no SKILL.md. Start from templates/skill/ (docs/skills.md)."
      continue
    fi
    if ! has_frontmatter "skills/$name/SKILL.md"; then
      case "$name" in
        wf-*)
          warn "skills/$name/SKILL.md has no frontmatter. Give it its name and the scheduled-workflow description, so a conversation never starts it by accident (docs/skills.md)."
          ;;
        *)
          fix "skills/$name/SKILL.md has no frontmatter with a name and a description, so the engine cannot find it (docs/skills.md)."
          continue
          ;;
      esac
    fi
    ok=$((ok + 1))
    if [ -f SKILLS.md ] && ! grep -Fq -- "$name" SKILLS.md; then
      unlisted="${unlisted:+$unlisted$nl}$name"
    fi
  done
  if [ "$total" -eq 0 ]; then
    note "skills/ has no skill yet."
  elif [ "$ok" -eq "$total" ]; then
    pass "every skill has a SKILL.md the engine can find ($total)"
  fi
  if [ -n "$unlisted" ]; then
    warn "skills missing from SKILLS.md, the readable index (docs/skills.md):"
    show_list "$unlisted"
  fi
else
  note "no skills/ folder to check."
fi

# ---------------------------------------------------------------- memory and archives
section "Memory and archives"
if [ -d memory ]; then
  daily=0
  odd=""
  for path in memory/*; do
    name=${path##*/}
    if [ -d "$path" ]; then
      [ "$name" = "archive" ] || odd="${odd:+$odd$nl}$path/"
      continue
    fi
    case "$name" in
      [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].md|[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-*.md) daily=$((daily + 1)) ;;
      *) odd="${odd:+$odd$nl}$path" ;;
    esac
  done
  if [ "$daily" -gt 0 ]; then
    pass "memory/: daily files ($daily)"
  else
    note "memory/ has no daily file yet. The first one is memory/YYYY-MM-DD.md."
  fi
  if [ -n "$odd" ]; then
    warn "memory/ holds things that are not daily files. Move them to their home (docs/workspace.md):"
    show_list "$odd"
  fi
fi
if [ -d archives ]; then
  archived=0
  for path in archives/*; do archived=$((archived + 1)); done
  if [ "$archived" -gt 0 ] && [ ! -f archives/DONE-LOG.md ]; then
    warn "archives/ has content but no DONE-LOG.md, the one-line record of what moved and why (docs/workspace.md)."
  elif [ "$archived" -gt 0 ]; then
    pass "archives/DONE-LOG.md"
  fi
fi

# ---------------------------------------------------------------- secrets
section "Secrets in Markdown files"
md_count=$(find . -name .git -prune -o -name node_modules -prune -o -type f -name '*.md' -print | wc -l | tr -d '[:space:]')

# Print file:line:match for every match in Markdown files. $1: "" or -i, $2: extended regular expression.
scan_md() {
  grep -rIno $1 -E --include='*.md' --exclude-dir=.git --exclude-dir=node_modules -e "$2" . 2>/dev/null
}

# Known key formats and private keys: these must be fixed.
strong='-----BEGIN [A-Z ]*PRIVATE KEY-----|(^|[^A-Za-z0-9_-])sk-[A-Za-z0-9_-]{20,}|gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{30,}|xox[abposr]-[A-Za-z0-9-]{10,}|(AKIA|ASIA)[0-9A-Z]{16}|AIza[0-9A-Za-z_-]{35}|(sk|rk)_live_[0-9A-Za-z]{16,}|whsec_[0-9A-Za-z]{20,}|eyJ[A-Za-z0-9_-]{10,}\.eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}|[MNO][A-Za-z0-9_-]{23,27}\.[A-Za-z0-9_-]{6}\.[A-Za-z0-9_-]{27,40}'
strong_hits=$(scan_md "" "$strong" | awk '
  {
    i = index($0, ":"); file = substr($0, 1, i - 1); rest = substr($0, i + 1)
    j = index(rest, ":"); line = substr(rest, 1, j - 1); m = substr(rest, j + 1)
    sub(/^\.\//, "", file)
    if (m ~ /PRIVATE KEY/) kind = "private key"
    else if (m !~ /[0-9]/) next
    else if (m ~ /^eyJ/) kind = "signed token"
    else if (m ~ /gh[pousr]_|github_pat_/) kind = "GitHub token"
    else if (m ~ /xox[abposr]-/) kind = "Slack token"
    else if (m ~ /^(AKIA|ASIA)/) kind = "cloud access key"
    else if (m ~ /^AIza/) kind = "Google key"
    else if (m ~ /_live_|^whsec_/) kind = "payment key"
    else if (m ~ /sk-/) kind = "API key"
    else kind = "bot token"
    print file ":" line "  (" kind ")"
  }' | sort -u)

# Values that only look like secrets after a key word: these are warnings to look at.
weak='(api[_-]?key|secret|token|password|passwd|access[_-]?key)["'"'"'`]?[[:space:]]*[:=][[:space:]]*["'"'"'`]?[A-Za-z0-9_+=-]{20,}|bearer[[:space:]]+[A-Za-z0-9_.=-]{20,}|[a-z][a-z0-9+.-]*://[^/[:space:]:@]+:[^/[:space:]@]{6,}@'
weak_hits=$(scan_md -i "$weak" | awk -v q="'" '
  {
    i = index($0, ":"); file = substr($0, 1, i - 1); rest = substr($0, i + 1)
    j = index(rest, ":"); line = substr(rest, 1, j - 1); m = substr(rest, j + 1)
    sub(/^\.\//, "", file)
    low = tolower(m)
    if (index(low, "://") > 0) {
      if (m ~ /[{}<>]/ || low ~ /:(password|pass|secret|xxx+)@/) next
      kind = "address with a password"
    } else {
      v = m
      if (low ~ /^bearer/) { sub(/^[A-Za-z]+[ \t]+/, "", v); kind = "bearer token" }
      else { sub(/^[^:=]*[:=][ \t]*/, "", v); kind = "value after a key word" }
      gsub(q, "", v); gsub(/["`]/, "", v)
      if (v !~ /[0-9]/ || v !~ /[A-Za-z]/) next
    }
    print file ":" line "  (" kind ")"
  }' | sort -u)

# A line already reported as a known key format is not repeated as a warning.
if [ -n "$strong_hits" ] && [ -n "$weak_hits" ]; then
  strong_locs=$(printf '%s\n' "$strong_hits" | sed 's/  (.*$//')
  weak_hits=$(printf '%s\n' "$weak_hits" | while IFS= read -r item; do
    loc=${item%%  (*}
    case "$nl$strong_locs$nl" in *"$nl$loc$nl"*) continue ;; esac
    printf '%s\n' "$item"
  done)
fi

if [ -z "$strong_hits" ] && [ -z "$weak_hits" ]; then
  pass "no secret-looking values in $md_count Markdown files"
fi
if [ -n "$strong_hits" ]; then
  fix "secret values in Markdown files (file and line only, values not shown). Move each value to a protected place outside the workspace and write only its location in TOOLS.md (docs/workspace.md):"
  show_list "$strong_hits"
fi
if [ -n "$weak_hits" ]; then
  warn "possible secrets in Markdown files. Look at each line and move any real value out of the workspace:"
  show_list "$weak_hits"
fi
if [ -n "$strong_hits$weak_hits" ] && [ -e .git ]; then
  note "a value that was ever committed stays in Git history: ask your person whether it should be renewed."
fi

# ---------------------------------------------------------------- records
section "Records"
if [ -f .playbook/installed.json ]; then
  installed=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' .playbook/installed.json | head -n 1)
  if [ -n "$installed" ]; then
    pass "installed receipt: version $installed"
    if [ "$guide_version" != "unknown" ] && [ "$installed" != "$guide_version" ]; then
      note "this guide is version $guide_version. To move the workspace to it, follow docs/update.md."
    fi
  else
    fix ".playbook/installed.json has no version. Rewrite it as docs/update.md shows."
  fi
else
  warn "no installed receipt yet (.playbook/installed.json). Write it at the end of setup (docs/update.md)."
fi
if [ -d .git ]; then
  if [ -f .git/config ] && grep -q '^\[remote ' .git/config; then
    pass "Git repository with a remote copy for backups"
  else
    warn "Git repository without a remote copy, so the daily backup has nowhere to go (docs/upkeep.md)."
  fi
elif [ -f .git ]; then
  note "Git worktree: its remote is not checked here."
else
  warn "not a Git repository. The daily backup and the update's way back need Git (docs/upkeep.md, docs/update.md)."
fi

# ---------------------------------------------------------------- result
printf '\nSummary: PASS %d, FIX %d, WARN %d.\n' "$passes" "$fixes" "$warns"
if [ "$fixes" -eq 0 ]; then
  if [ "$warns" -gt 0 ]; then
    printf 'Result: every required check passes. Read the warnings: they do not block, but each one points to something to look at.\n'
  else
    printf 'Result: every required check passes.\n'
  fi
  printf 'Next: the loading check and the six questions in docs/verify.md.\n'
  exit 0
fi
printf 'Result: fix every line marked FIX (%d), then run this check again.\n' "$fixes"
exit 1

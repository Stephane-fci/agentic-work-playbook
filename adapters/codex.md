# Codex

## With Agent Bridges

Nothing extra. The bridge delivers every top-level Markdown file at every turn, and Codex reads `AGENTS.md` itself ([Agent Bridges](agent-bridges.md)). Keep `AGENTS.md` for Codex's own instructions ([boot files](../docs/boot-files.md)).

## Without the bridge

This covers the Codex command line and Codex in the ChatGPT desktop app, working in the workspace folder. Codex reads its instructions when a session starts, has no way to import one file from another, and caps project instructions at 32 KiB. So `AGENTS.md` alone cannot bring in `USER.md`, `RULES.md` and the other boot files. A hook can, as shown below.

The facts below were checked against Codex's official documentation in October 2026. Each one names its source.

### 1. Make the workspace a trusted project

Codex treats the folder that holds `.git` as the project root. Run `git init` at the top of the workspace if it is not a Git repository yet (the daily backup needs one anyway). Source: https://learn.chatgpt.com/docs/config-file/config-advanced

Open Codex there and trust the folder when it asks. In a folder that is not trusted, Codex ignores the project's `AGENTS.md` and its project hooks. Sources: https://github.com/openai/codex/pull/39837 and https://learn.chatgpt.com/docs/hooks

### 2. What Codex reads by itself

Codex reads `AGENTS.md` (or `AGENTS.override.md`) in each folder from the project root down to the folder it started in, at most one file per folder. It builds this chain "once per run; in the TUI this usually means once per launched session". It stops adding files once their combined size reaches `project_doc_max_bytes`, 32 KiB by default. The documentation describes no import syntax for `AGENTS.md`. Source: https://learn.chatgpt.com/docs/agent-configuration/agents-md

So after an edit to `AGENTS.md`, start a new session before you rely on it.

### 3. Recommended: a hook that prints the boot files

A hook is a small command Codex runs at a set moment. A `SessionStart` hook runs when a session starts, resumes, is cleared or is compacted, and its text "is added as extra developer context". After a compaction, it runs again before the next model request, even in the middle of a turn. Source: https://learn.chatgpt.com/docs/hooks

Keep `AGENTS.md` short, for Codex's own instructions, and add two files. First `.codex/hooks.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup|resume|clear|compact",
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$(git rev-parse --show-toplevel)/.codex/hooks/boot_files.py\"",
            "additionalContextLimit": 20000
          }
        ]
      }
    ]
  }
}
```

Then `.codex/hooks/boot_files.py`, which prints every top-level Markdown file and today's and yesterday's daily memory files:

```python
# Prints every boot file for Codex when a session starts, resumes, is cleared or compacted.
import datetime, json, pathlib

root = pathlib.Path(__file__).resolve().parents[2]
skip = {"AGENTS.md", "AGENTS.override.md", "CLAUDE.md"}  # Codex reads its own file itself; CLAUDE.md belongs to Claude Code
parts = []
for path in sorted(root.glob("*.md")):
    if path.name not in skip and not path.name.startswith("."):
        parts.append(f"# File: {path.name}\n\n{path.read_text(encoding='utf-8')}")
today = datetime.date.today()
for day in (today, today - datetime.timedelta(days=1)):
    daily = root / "memory" / f"{day.isoformat()}.md"
    if daily.exists():
        parts.append(f"# File: memory/{daily.name}\n\n{daily.read_text(encoding='utf-8')}")
print(json.dumps({"hookSpecificOutput": {"hookEventName": "SessionStart", "additionalContext": "\n\n".join(parts)}}))
```

When two agents share the workspace, add the other agent's identity files to `skip`.

`additionalContextLimit` matters. By default Codex passes about 2,500 tokens of a hook's text (tokens are the units the model counts text in, about four characters of English each). Above the limit, Codex saves the text to a file and gives the model only the beginning and the end. Set the limit a little above the size of your boot files in tokens: 60 KB of files is about 15,000 tokens. Raise it when the files grow. Do not set it to 0 (no limit): the documentation warns that one hook could then fill the whole context. Source: https://learn.chatgpt.com/docs/hooks

New and changed hooks must be trusted before they run: open `/hooks` in Codex once and trust this one. On Windows, the hook takes a separate `commandWindows` line with the command for that system. Source: https://learn.chatgpt.com/docs/hooks. Whether the desktop app runs hooks exactly like the command line is not confirmed in the documentation; check it with step 5.

The limit of this route: the hook brings the current files when a session starts, resumes, is cleared or is compacted, not at every message. After editing a boot file, start a new session before you rely on the change. The bridge removes this limit.

The simpler alternative, without a hook: when all boot files together stay under 32 KiB, a small script can join them into `AGENTS.md`. Then `AGENTS.md` is a generated copy: never edit it by hand, run the script again after every edit of a boot file, and start a new session. The cap can be raised with `project_doc_max_bytes` in Codex's configuration (https://learn.chatgpt.com/docs/agent-configuration/agents-md). The daily memory files are not in the copy, so `AGENTS.md` must tell the agent to read today's and yesterday's file first in a new conversation.

### 4. Skills

Codex finds skills in `.agents/skills` (in the folder it started in and each folder above it, up to the project root) and in `~/.agents/skills`, not in a plain `skills/` folder. Every `SKILL.md` must start with a `name` and a `description`. Link the folder once, from the top of the workspace:

```bash
mkdir -p .agents && { [ -e .agents/skills ] || ln -s ../skills .agents/skills; }
```

Codex notices edited skills by itself; restart it if a new skill does not appear. Source: https://learn.chatgpt.com/docs/build-skills. More on skills: [skills](../docs/skills.md).

### Scheduled runs

Without the bridge, an upkeep job is started by the server's own scheduler, and nobody is there to approve commands ([upkeep](../docs/upkeep.md)). Start it from the workspace folder with a sandbox that may write in the workspace, and with network access when the job pushes to the backup:

```bash
codex exec --full-auto -c sandbox_workspace_write.network_access=true "Read skills/wf-<name>/SKILL.md and execute it"
```

Run each job once by hand with the same command and check its commit and push before you schedule it.

### 5. Check

1. Run `/status` in Codex: it lists the `AGENTS.md` files in use. Source: https://github.com/openai/codex/pull/40502
2. Run `/hooks`: the boot-file hook is trusted and switched on.
3. Start a new session and run the loading check in [verify](../docs/verify.md): the agent quotes every boot file's two secret check lines without opening a file. A last line missing from a long file means the hook's limit cut it: raise `additionalContextLimit`.
4. Edit one of those last lines and ask again in the same session: expect the old line. Start a new session and ask again: expect the new one. This shows your person the limit of this route in plain terms.

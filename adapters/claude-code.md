# Claude Code

## With Agent Bridges

Nothing extra. The bridge delivers every top-level Markdown file at every turn ([Agent Bridges](agent-bridges.md)). Keep a `CLAUDE.md` at the top of the workspace for Claude Code's own instructions ([boot files](../docs/boot-files.md)), with the `@` lines from step 2 below, so a plain session works too. The bridge never reads a file twice.

## Without the bridge

This covers Claude Code in a terminal, an editor or the desktop app, working in the workspace folder. It works, with one honest limit: the boot files are read when a session starts, not at every turn.

The facts below were checked against Claude Code's official documentation in October 2026. Each one names its source.

### 1. Start in the workspace

Always start Claude Code from the workspace folder. At launch it loads the `CLAUDE.md` of the folder it starts in and of every folder above it. Source: https://code.claude.com/docs/en/memory

### 2. Import every boot file

Write a `CLAUDE.md` at the top of the workspace with one `@` line per boot file you have. Each line pulls that file in when the session starts:

```text
@WORKSPACE.md
@OPERATING-MODE.md
@COMMUNICATION.md
@SOUL.md
@IDENTITY.md
@USER.md
@RULES.md
@TOOLS.md
@MEMORY.md
@SKILLS.md
```

Add one line for every other Markdown file at the top of the workspace, such as a `COMPANY.md`. Without the bridge, a top-level file with no `@` line is not loaded.

The rules for these lines, from the documentation (https://code.claude.com/docs/en/memory):

- Write them as plain lines. An `@` inside backticks or a code block is not imported, and a path in quotes is not imported at all.
- Paths are relative to the file that holds the line.
- Keep every boot file inside the workspace. An import that points outside the folder Claude Code started in asks for approval the first time, and if it is declined, it stays off.
- An imported file can import others, up to four levels deep.
- A path with a space needs a backslash before the space.

When the workspace also keeps an `AGENTS.md` (for Codex), add `@AGENTS.md`. By default Claude Code reads `AGENTS.md` by itself only when there is no `CLAUDE.md`, and it never reads it twice. Source: https://code.claude.com/docs/en/memory

An `@` line names a fixed file, so it cannot follow the date of the daily memory files. Add one plain sentence to `CLAUDE.md` instead: "In a new conversation, first read today's and yesterday's daily memory files in memory/, if they exist."

### 3. The limit: read once per session

Claude Code reads `CLAUDE.md` and its imports once, when the session starts, and keeps that copy. The documentation says: "Editing them mid-session does not invalidate the cache, but the edit also doesn't apply. Claude keeps working with the version that was loaded at session start. The new content loads on the next `/clear`, `/compact`, or restart." Source: https://code.claude.com/docs/en/prompt-caching

So after you or the agent edit a boot file, start a new session (or run `/clear`) before you rely on the change. A long session keeps working with the old text. This is the main reason the guide recommends the bridge, which starts a fresh Claude Code process at every turn.

A hook could send changed files again before each message, but each hook's output is capped at 10,000 characters, and beyond that Claude only sees a short preview (https://code.claude.com/docs/en/hooks). For most people the bridge is the simpler route.

### 4. Size

The documentation recommends under 200 lines per `CLAUDE.md` file: longer files cost more context and are followed less well. Source: https://code.claude.com/docs/en/memory. Every imported file adds to what the agent carries in each session, so keep boot files short ([boot files](../docs/boot-files.md) gives size guidance).

### 5. Skills

Claude Code finds skills in `.claude/skills/<name>/SKILL.md`, not in a plain `skills/` folder. Link the folder once, from the top of the workspace:

```bash
mkdir -p .claude && { [ -e .claude/skills ] || ln -s ../skills .claude/skills; }
```

On Windows, making a link needs Developer Mode or an administrator window. A change to a skill applies in the same session. If `.claude/skills` did not exist when the session started, run `/reload-skills`. Source: https://code.claude.com/docs/en/skills. More on skills: [skills](../docs/skills.md).

### 6. Check

1. In a session, run `/context` and look at the list under "Memory files": `CLAUDE.md` and every imported file must be there. `/memory` also lists the instruction files. Source: https://code.claude.com/docs/en/memory
2. Start a new session and run the loading check in [verify](../docs/verify.md): the agent quotes every boot file's two secret check lines without opening a file.
3. Edit one of those last lines and ask again in the same interactive session: expect the old line. Start a new session and ask again: expect the new one. This shows your person the limit from step 3 in plain terms. A print call (`claude -p`, even with `--resume`) loads the files again each time, so it shows the new line at once.

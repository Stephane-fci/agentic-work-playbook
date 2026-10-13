# Agent Bridges: the recommended connection

Agent Bridges connects Claude Code or Codex to Discord (and Slack, if you want it) on your own Linux server. Each channel and each thread is one long conversation with the agent. It is a separate product by the same author, with its own install guide and releases: https://github.com/Stephane-fci/agent-bridges. The repository may not be public yet; if the link does not open, ask the author for access.

This guide recommends it for one reason above all. The method needs every boot file read in full at every turn, fresh from disk ([way of working](../docs/way-of-working.md)). Neither engine does that by itself ([Claude Code](claude-code.md), [Codex](codex.md)). The bridge does, on both.

## Install

Follow the bridge's own guide, `docs/INSTALL-FOR-AGENT.md` in its repository: give it to your agent and say "Install the bridge by following this guide". It covers the server, the Discord bot, the login and the first test.

When the workspace already exists, add `--workspace` with its folder, so the bridge works there instead of in an empty folder:

```bash
sudo agent-bridges/install/install.sh --bridge claude --owner OWNER_ID --server SERVER_ID --workspace /path/to/workspace
```

Use `--bridge codex` for Codex. The installer also links the skills. Claude Code looks in `.claude/skills` and Codex in `.agents/skills`, neither in a plain `skills/` folder, so the installer links them to the workspace's `skills/` folder ([skills](../docs/skills.md)). It never replaces something already in a link's place.

## How it delivers the boot files

Every Markdown file at the top of the workspace (not in a folder, not a hidden file) is part of the agent's instructions at every turn. A changed file is read again at the next turn, a new file is picked up, and a deleted file is dropped. There is nothing to set: add a file such as `TEAM.md` at the top and every conversation has it at its next message. A file over 256 KiB is left out, and the bridge's log says so.

How each engine receives them:

- Claude Code: the bridge writes the list as `@` import lines in a `CLAUDE.md` inside its own state folder, never in the workspace, and hands Claude Code that folder at every turn. The bridge starts one Claude Code process per turn, and Claude Code reads every imported file when it starts, so each turn sees the current files. After a compaction (when a long conversation is shrunk into a summary) they come back by themselves. A file that the workspace's own `CLAUDE.md` already imports is read once, not twice. Two kinds of file cannot be listed, and the log says so: a file whose path has a space, and an extra file outside the workspace.
- Codex: at the top of each turn, the bridge sends the files that changed since the conversation last saw them, and the names of files that are gone. A new conversation, and the first turn after a compaction or a stopped turn, get every file again. Codex reads `AGENTS.md` itself and picks up a changed one on its own, so the bridge never sends it.

Each engine keeps its own instruction file: Claude Code reads `CLAUDE.md`, Codex reads `AGENTS.md` (or `AGENTS.override.md` when there is one). Every other top-level file goes through the bridge, `AGENTS.md` included for Claude Code. What belongs in each file: [boot files](../docs/boot-files.md).

Keep the `@` lines in the workspace's `CLAUDE.md` anyway ([Claude Code](claude-code.md)). The bridge still reads each file once, and a plain Claude Code session in a terminal gets them too.

Two honest limits. A removed file stops being sent, but what the agent read before stays in that conversation's history until it is compacted or a new conversation starts. And delivery is not obedience: the bridge makes sure the agent has the files; the files still have to be clear.

## The two settings this guide uses

The bridge's settings live in `/etc/agent-bridges/<instance>/config.json`, changed with sudo. Add today's and yesterday's daily memory files:

```json
"workspaceFiles": {
  "also": ["memory/{today}.md", "memory/{yesterday}.md"]
}
```

`workspaceFiles.also` adds files that are not at the top of the workspace, relative to the workspace. `{today}` and `{yesterday}` become dates, so the agent has the two latest daily memory files at every turn and does not need to read them as a first step. A missing file is skipped. The dates are UTC dates, so near midnight "today" can differ from your own date.

`workspaceFiles.except` leaves files out by name. `*` stands for any text, and letter case does not matter. You need it in two cases. When two agents share one workspace, each bridge leaves out the other agent's identity files:

```json
"workspaceFiles": {
  "except": ["SOUL.md", "IDENTITY.md"],
  "also": ["memory/{today}.md", "memory/{yesterday}.md"]
}
```

And when the workspace holds the other engine's own file: a Codex bridge in a workspace that also has a `CLAUDE.md` for Claude Code takes `"except": ["CLAUDE.md"]`. One agent alone in its workspace needs no `except`.

A change to `config.json` (other than who may talk to the bot) applies at the bridge's next start: its daily quiet restart, or a quiet restart you ask for (`docs/updating.md` in the bridge's repository). A change to the boot files themselves needs no restart.

## Upkeep jobs

The bridge runs the agent's own repeating jobs, the same way on Claude Code and Codex, even when nobody writes. That is where this guide's upkeep jobs live ([upkeep](../docs/upkeep.md)). There are two kinds:

- A turn job wakes the agent in a channel with a task. For upkeep, the task only points to the job's `wf-` skill, which holds all the behavior.
- A script job runs a command in the workspace without the model and posts its output, or only its failures. It suits purely mechanical work.

The agent makes the jobs itself, from the channel where the reports should go (or with `--channel` and a channel id):

```bash
agent-bridges job add --name "Daily backup" --cron "50 2 * * *" --tz Europe/Paris --task "Follow skills/wf-git-backup/SKILL.md"
agent-bridges job list
```

`agent-bridges job help` explains every option. The list lives in the workspace, in `.agent-bridges/<instance>/jobs.json`. After the bridge was off, the newest missed run happens once, up to a day late. A failed run posts a warning in its channel. Keep one scheduler: do not put the same jobs in the server's own scheduler as well.

## Tested engine updates

The engines' own self-updates are off. Every Sunday at 03:30 server time, the bridge installs the newest Claude Code or Codex beside the version in use and runs real test turns with it (for Codex, also a resumed conversation, a helper when helpers are on, and a compaction). Only a version that passes is used. It starts at the next daily quiet restart, at 04:30 server time, which waits until no answer is running; if the bridge does not come back up on the new version, it steps back to the one before. `agent-bridges version` shows the version in use, the one waiting, and any version left out with the reason.

A new release of the bridge itself installs the way you installed it. It never overwrites your settings, keys or workspace. The guide's own version is separate from the bridge's and the engines' versions ([update](../docs/update.md)).

## Check that it works

1. Run `sudo agent-bridges doctor` (an agent without admin rights asks its person to run it and paste the "Workspace files" line). Its "Workspace files" line lists every file the agent gets at every turn, and names the engine's own file. Every boot file must be there, and nothing you meant to leave out.
2. Run the loading check in [verify](../docs/verify.md): a unique last line in each boot file, a fresh turn, and the agent quotes every last line without opening a file.
3. Change one of those last lines, send a new message in the same conversation, and ask again. The agent must quote the new line. This is what the bridge adds over a plain engine.

An agent saying it read everything is not proof. The quoted lines are.

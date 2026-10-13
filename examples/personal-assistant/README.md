# Example: a personal assistant

This folder is a complete set of root boot files for the own-assistant profile ([boot files](../../docs/boot-files.md#three-profiles)), filled from the [templates](../../templates/root/). Everything in it is invented: the people, the shop, the clients, the accounts, the dates and the paths.

## Who is in it

Alex Martin runs Fernway, a small online plant shop, and takes marketing work for two clients, Maple Street Bakery and PulseFit. Nora is Alex's own assistant. It runs on Claude Code and talks with Alex in Discord through [Agent Bridges](../../adapters/agent-bridges.md). These are the same made-up names as the example legend in [discord.md](../../docs/discord.md#a-fictional-example-legend), so the Discord section of RULES.md matches it.

## The files

- [SOUL.md](SOUL.md): Nora's character and limits.
- [IDENTITY.md](IDENTITY.md): name, role, vibe and language.
- [USER.md](USER.md): Alex, the business, how Alex decides, and Alex's writing voice.
- [RULES.md](RULES.md): who decides, approvals and standing permissions, messages to people, jobs, and the Discord legend.
- [TOOLS.md](TOOLS.md): the machine, the connected tools with where each key is kept, planned tools and forbidden ones.
- [MEMORY.md](MEMORY.md): the live board on one day.
- [SKILLS.md](SKILLS.md): a short index of Nora's skills.
- [AGENTS.md](AGENTS.md) and [CLAUDE.md](CLAUDE.md): the engine connection.

The three shared method files are not copied here. Nora uses [WORKSPACE.md](../../templates/root/WORKSPACE.md), [OPERATING-MODE.md](../../templates/root/OPERATING-MODE.md) and [COMMUNICATION.md](../../templates/root/COMMUNICATION.md) as they are, with the defaults in COMMUNICATION.md unchanged. In a real workspace they sit at the root beside these files, which is why CLAUDE.md imports them.

## What the example shows

- Each fact has one home. Alex's voice is only in USER.md. The rule about clients' logins is only in TOOLS.md. The Discord legend is only in RULES.md.
- Rules are short. Each names who decided it and when, with no story behind it.
- A standing permission, like the order-status replies, is written once, so Nora never asks for it again.
- TOOLS.md says where each key is kept and when the tool was last checked, never the key itself.
- An unknown fact stays visibly unknown: `{unknown: ask}` in USER.md.
- The board in MEMORY.md is under 1 KB: what is happening now, one line per project, nothing older.
- AGENTS.md holds the engine connection; CLAUDE.md holds only the import lines and what is specific to Claude Code.
- The filled files total about 17 KB. With the three shared method files the whole set is about 38 KB, a normal size for a new agent.

## This README is not a boot file

This page is for readers of the guide. Never copy it into a workspace root: every Markdown file at the root is a boot file, so the agent would read it at every turn.

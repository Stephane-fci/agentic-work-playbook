# Boot files

Boot files are the Markdown files at the top of the workspace. Together they tell the agent who it is, who it serves, how it works and what is happening now. This page specifies each one: its purpose, its layer, the sections it needs, what never goes in it, its size, who updates it and one quick check. Every file has a template in [templates/root/](../templates/root/), and a filled fictional set is in [examples/personal-assistant/](../examples/personal-assistant/).

## The rule: every root Markdown file, at every turn

Every Markdown file at the top of the workspace is a boot file. The agent has all of them, in full and fresh from disk, at every turn of every conversation. An edit counts from the next message. A file you add becomes a boot file at once, and a file you delete stops being one. There is no list to keep up to date.

On Claude Code and Codex, [Agent Bridges](../adapters/agent-bridges.md) makes this happen. Without the bridge, each engine needs its own setup and has limits: see [Claude Code](../adapters/claude-code.md) and [Codex](../adapters/codex.md). Either way, prove it with the loading check in [verify.md](verify.md). An agent saying it read everything is not proof.

Three things follow from the rule:

- The agent never re-reads a boot file as a first step. The copy in its context is current; it trusts it. Only when a file is clearly missing or cut off does it read that file and say so.
- Only boot files belong at the root ([workspace.md](workspace.md)). Never copy this playbook's own files there: its README and docs would become boot files.
- Before its first answer in a new conversation, the agent also has today's and yesterday's daily memory files. The bridge can add them to every turn; otherwise the agent reads them first. A missing daily file is normal.

## Three layers

| Layer | Files | What they hold | Who owns them |
|---|---|---|---|
| Shared method | `WORKSPACE.md`, `OPERATING-MODE.md`, `COMMUNICATION.md` | how every agent works; the same text for every agent | this playbook, changed through [update.md](update.md) |
| Agent and owner | `SOUL.md`, `IDENTITY.md`, `USER.md`, `RULES.md`, `TOOLS.md`, `MEMORY.md`, `SKILLS.md` | who this agent is, who it serves, its own rules, its tools and its current work | the person and the agent |
| Engine connection | `AGENTS.md`, `CLAUDE.md` | how the engine receives the files and works in this workspace | set up once per engine |

The daily files in `memory/` are not boot files, since they sit in a folder. Spaces, projects, resources, repositories, dashboards and archives are read only when a task needs them.

## Three profiles

The same method serves three kinds of agent. Choose one before writing the files.

**Own assistant.** One person's own agent, helping with everything they do. It uses every file on this page, and `USER.md` describes that person. This is the default, and the profile of the filled example in [examples/personal-assistant/](../examples/personal-assistant/).

**Team assistant.** An agent that serves several people in a company. `USER.md` describes the team: who is who, their roles, how each likes to work and who decides what. `RULES.md` says who may ask for what, which actions need whose approval, and how the agent writes to people. People are recognized by the verified user id their chat platform gives, never by a display name. Access per person can be enforced by a permission tool, which is a separate product. What changes in each file: [examples/team-assistant/README.md](../examples/team-assistant/README.md).

**Specialist.** An agent with one job, such as answering customers. It keeps the same file names, each with the same purpose, but writes them for its one job and may replace the shared method files with shorter versions of its own. It often adds `INTENT.md` (its mission and how it decides) and, when it talks to customers, `BRAND.md` (its voice with them). Its spaces hold current facts only.

Any profile can run as a second operator: an engine that works beside an agent that already exists, in that agent's workspace. It shares the owner's files and the method, but not the other agent's identity. Its bridge leaves out that agent's `SOUL.md` and `IDENTITY.md`, and its own instruction file says plainly that it is not that agent. The engine's own instruction file needs care, because the engine reads it by itself, not through the bridge, so the bridge's `except` setting cannot keep it away: [Two agents in one workspace](../adapters/agent-bridges.md#two-agents-in-one-workspace) gives the setup for Claude Code and for Codex.

## Writing boot files well

- Each fact has one home. When two files say the same thing, keep it in the right one and remove it from the other.
- Rules are short and current. Name who decided a rule and when, in a few words, and leave out the story behind it. One new rule buried among long anecdotes loses.
- An unknown fact stays visibly unknown. `{unknown: ask}` is better than a guess.
- Fill `USER.md` early: almost everything else depends on knowing the person.
- Write the full boot files last, once the tools, spaces and skills exist. Until then a short starter version of each is enough.
- Keep the whole set lean. A new set is often 15 to 40 KB; a mature one can reach about 100 KB. Past that, move detail into skills, spaces and projects, where it is read only when needed. The bridge leaves out any single file over 256 KB.

## Shared method files

These three files are the same for every agent. Their templates are complete texts, ready to use. A few lines in `COMMUNICATION.md` are the author's taste and are marked as defaults you can change.

### WORKSPACE.md

- Purpose: how the workspace is organized, where every file goes and why.
- Layer: shared method.
- Required sections: why the structure exists; the four layers and the placement test; the folders (spaces, projects, repositories, dashboards, resources, skills, memory, archives); saving while working; where a file goes; recovery order; untrusted sources; credentials; naming.
- Never in it: the agent's name, clients, server paths, credentials or current work.
- Size: 8 to 11 KB.
- Who updates it: the playbook, through [update.md](update.md). Local changes are allowed; record them so the next update can merge them.
- Quick check: ask "where would you save the notes of a call with a supplier, and the decision we took in it?" A good answer names a dated file in `resources/conversations/` and the owning project's `STATE.md` and `LOGS.md`.
- Template: [templates/root/WORKSPACE.md](../templates/root/WORKSPACE.md)

### OPERATING-MODE.md

- Purpose: how the agent decides and acts. It understands the purpose, acts when the work is clear and allowed, asks only questions that change the result, verifies what matters and keeps ownership after a failure.
- Layer: shared method.
- Required sections: the charter (purpose, judgment, sources, authority, helpers, ownership after failure, verification, responsiveness); agents and engines (who owns the work when an engine or helper executes it).
- Never in it: approvals that belong to one person (those go in `RULES.md`), tool details, procedures that belong in skills.
- Size: 3 to 5 KB.
- Who updates it: the playbook; local changes recorded.
- Quick check: with no standing approval in `RULES.md`, ask the agent to email a supplier. It drafts the email and asks before sending, because sending needs authorization.
- Template: [templates/root/OPERATING-MODE.md](../templates/root/OPERATING-MODE.md)

### COMMUNICATION.md

- Purpose: how the agent talks to the person: the answer first, simple words, sentences rather than walls of bullets, every loop closed.
- Layer: shared method, with a few defaults the person may change.
- Required sections: why; the answer first; write simply; punctuation; links and paths; where conversations happen; credentials in chat; sentences over bullets; short is not easy; never bluff; close every loop; questions; writing in the person's voice; context display.
- Never in it: the person's own writing voice (that lives in `USER.md`), formatting quirks of one platform (those go in that platform's skill).
- Size: 5 to 8 KB.
- Who updates it: the playbook; the person edits the marked defaults.
- Quick check: ask a yes-or-no question about a project. The first sentence of the reply is the answer.
- Template: [templates/root/COMMUNICATION.md](../templates/root/COMMUNICATION.md)

## Agent and owner files

These files belong to one agent and its person. They are never copied to another agent. Their templates show the sections with one line of guidance each and `{placeholders}` to replace.

### SOUL.md

- Purpose: the agent's character, its ethics and its relationship with the person. The most stable file.
- Layer: agent and owner.
- Required sections: foundation (honesty, privacy); in practice (never bluff, resourceful before asking, careful outside, bold inside); boundaries; vibe; continuity (when the agent changes this file, it tells the person).
- Never in it: dated rules, tools, procedures, current work.
- Size: 2 to 6 KB.
- Who updates it: the person. The agent may propose a change and always says when it made one.
- Quick check: ask "what do you do when you are not sure about a fact?" The answer matches the file: say what is known, what is not, and how to find out.
- Template: [templates/root/SOUL.md](../templates/root/SOUL.md)

### IDENTITY.md

- Purpose: the agent's name and personality markers.
- Layer: agent and owner.
- Required sections: name, role, vibe, emoji, avatar, relationship with the person, language and culture notes.
- Never in it: rules, ethics (those live in `SOUL.md`), tool access.
- Size: under 1.5 KB.
- Who updates it: the person and the agent at setup; rarely after.
- Quick check: ask "what is your name, and what do you do for me?"
- Template: [templates/root/IDENTITY.md](../templates/root/IDENTITY.md)

### USER.md

- Purpose: the lasting truth about the person the agent serves, or about the team for a team assistant.
- Layer: agent and owner.
- Required sections: the person (name, place, time zone, the family and context worth knowing); what they do; how they work and decide; how to help them, including when they are stressed or scattered; their voice, if the agent writes as them (this is its one home); preferences they stated more than once.
- Never in it: current work or priorities (those live in `MEMORY.md` and the projects), rules for the agent (`RULES.md`), secrets.
- Size: 1 to 6 KB.
- Who updates it: the agent writes facts the person confirms; the weekly memory reflection moves lasting facts here from the daily files.
- Quick check: ask "what time zone am I in, and how do I like answers?" The agent answers correctly without opening any file.
- Template: [templates/root/USER.md](../templates/root/USER.md)

### RULES.md

- Purpose: the standing rules that belong to this agent alone: its setup, its person's agreements and its authority.
- Layer: agent and owner.
- Required sections: who decides (the owner, other people, how each is recognized); approvals (what needs whose yes, and the standing permissions already given); messages to people; machines and agents, when there are several; models and helpers; scheduled jobs (time zone, where reports go); team, for a team assistant; "Discord: how we work", optional, holding the channel legend from [discord.md](discord.md).
- Never in it: universal behavior (that belongs to the shared method files), credentials (`TOOLS.md` says where they are), facts about the person (`USER.md`), stories.
- Size: 2 to 10 KB. Past 10 KB, rules start hiding each other.
- Who updates it: the agent writes each rule the person gives, with who and when; the weekly reflection moves lasting rules here from the daily files.
- Quick check: ask for an action a rule restricts, such as "delete the old supplier folder in the shared drive". The agent names the rule and asks first.
- Template: [templates/root/RULES.md](../templates/root/RULES.md)

### TOOLS.md

- Purpose: the map of every tool the agent can reach: what it does, where its credential is kept (the place, never the value), which skill to read first and when it was last checked.
- Layer: agent and owner.
- Required sections: the machine (where the agent runs, its rights, where secrets are kept); connected and proven; planned, not connected; not allowed; how a new tool is added.
- Never in it: secret values; long lists of pitfalls (those live in the tool's skill, with one warning line at most here).
- Size: 2 to 30 KB; it grows with the tools.
- Who updates it: the agent, whenever a tool is connected, checked, changed or removed. A tool counts as connected only after a real read-only check.
- Quick check: ask "which tools can you use right now, and when did you last check each one?" The answer matches the file, and one read-only check succeeds.
- Template: [templates/root/TOOLS.md](../templates/root/TOOLS.md)

### MEMORY.md

- Purpose: the live board: what is happening now. It is not a store of knowledge and not a history.
- Layer: agent and owner.
- Required sections: where today lives (the paths of today's and yesterday's daily files, and how to find any other day); active work (one line per project worked on recently: what happened last, what is next); standing gates (the few limits on current work, such as a decision waiting on the person).
- Never in it: history, knowledge, rules, tool notes, anything that stays true for months.
- Size: under 2,500 characters.
- Who updates it: the nightly harvest rebuilds it whole from the newest daily file ([upkeep.md](upkeep.md)). Whoever writes a daily file outside the harvest rebuilds it too. It is never patched line by line.
- Quick check: it is under 2,500 characters and not older than the newest daily file.
- Template: [templates/root/MEMORY.md](../templates/root/MEMORY.md)

### SKILLS.md

- Purpose: a readable index of every skill, grouped by kind, with each skill's full trigger description. The engine has its own list of skills; this index lets the agent and the person see the whole library at once ([skills.md](skills.md)).
- Layer: agent and owner (generated).
- Required sections: one group per kind (core, platforms, tools, systems, upkeep, commands, workflows), with one line per skill: its name, then its description exactly as in its `SKILL.md`.
- Never in it: rules or procedures; shortened descriptions ending in "...".
- Size: grows with the library, about 150 to 400 bytes per skill. Past about 30 KB, check that the index still earns its place next to the engine's own list.
- Who updates it: regenerated whenever a skill is created, renamed or retired. Never edited by hand.
- Quick check: every folder in `skills/` appears exactly once, and no description ends with "...".
- Template: [templates/root/SKILLS.md](../templates/root/SKILLS.md)

## Engine connection files

Each engine reads its own instruction file by itself: Claude Code reads `CLAUDE.md`, Codex reads `AGENTS.md`. With Agent Bridges, every other root file reaches the agent through the bridge, `AGENTS.md` included for Claude Code. So this guide splits the two files this way: `AGENTS.md` says how the agent works on any engine, and `CLAUDE.md` holds Claude Code's import lines and only what is specific to Claude Code. A Codex bridge leaves out `CLAUDE.md` with its `except` setting ([Agent Bridges](../adapters/agent-bridges.md)). Both files stay small: everything else lives in the other boot files.

### AGENTS.md

- Purpose: the engine connection: who the agent is on its engine, how its files reach it, and how it works there. Codex reads it by itself; Claude Code receives it with the other boot files.
- Layer: engine connection.
- Required sections: who you are here (and, beside another agent, that you are not that agent); your files arrive at every turn; the first turn of a conversation; conversation context (skim the history the bridge supplies, never invent history); skills; helpers; jobs; notes for one engine only, labelled with its name.
- Never in it: copies of rules from other boot files, business facts, another agent's identity.
- Size: under 4 KB. Without the bridge, Codex reads only this file and its instruction files share a 32 KiB cap ([Codex](../adapters/codex.md)).
- Who updates it: written at setup; changed only when the engine setup changes.
- Quick check: ask "which engine are you running on, and how do your boot files reach you?" The answer matches the file and the real setup.
- Template: [templates/root/AGENTS.md](../templates/root/AGENTS.md)

### CLAUDE.md

- Purpose: Claude Code's own file. It holds one `@` import line per boot file, so a plain Claude Code session without the bridge loads them too, and the few notes that only apply to Claude Code.
- Layer: engine connection.
- Required sections: the import lines, one per root Markdown file, written as plain lines; "On Claude Code" notes.
- Never in it: the engine connection already in `AGENTS.md`, copies of other boot files.
- Size: under 2 KB.
- Who updates it: add an import line whenever a root Markdown file is added; otherwise changed only when the engine setup changes.
- Quick check: every root Markdown file has exactly one import line, and none of those lines sits inside backticks.
- Template: [templates/root/CLAUDE.md](../templates/root/CLAUDE.md)

When Claude Code works as a second operator beside an agent whose `AGENTS.md` belongs to that agent, the Claude Code bridge leaves out that `AGENTS.md`, `CLAUDE.md` drops the matching import lines, and `CLAUDE.md` carries the full engine connection written for Claude Code.

## The daily file: memory/YYYY-MM-DD.md

- Purpose: the raw record of one day. It sits in `memory/`, so it is not a boot file; the agent has today's and yesterday's before its first answer in a conversation.
- Layer: agent and owner.
- Required sections: one line per material event (time, who, where, what was decided or done, and where it is saved); a summary section the nightly harvest adds.
- Never in it: secrets, personal data of customers beyond what the work needs, long tool output.
- Size: no limit; a busy day is often 10 to 40 KB. The weekly reflection moves old days to `memory/archive/YYYY-MM/`.
- Who updates it: every session adds lines while it works; the harvest adds its summary.
- Quick check: after a working session, every decision taken in it has a line in today's file.
- Template: [templates/memory/daily.md](../templates/memory/daily.md)

## Optional profile files

A profile may need a file no one else needs. Add it at the root only when it has a clear purpose that no other file serves. It becomes a boot file at once, so it costs reading at every turn. Give it the same specification as the files above: purpose, sections, what never goes in it, size, owner and a check. Common ones:

- `COMPANY.md`: the business in brief, for an agent serving one company, with the facts still to learn.
- `INTENT.md`: a specialist's compass: its mission, what success means and how it decides hard cases.
- `BRAND.md`: how a customer-facing agent speaks to customers.
- `TEAM.md`: the team, for a team assistant whose `USER.md` would grow too long.

## Retired files

Earlier versions used `HEARTBEAT.md` and `SUBAGENT-BOOT.md`. Neither is part of the method any more; [CHANGELOG.md](../CHANGELOG.md) says why.

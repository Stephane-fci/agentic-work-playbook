# Skills

A skill teaches the agent one job well. Without it, the agent improvises from general knowledge. With it, the agent follows a proven method and inherits every lesson earlier runs paid for. Projects end; skills stay.

## What a skill is

A skill is a folder in `skills/` with a `SKILL.md` file. The file starts with a name and a description:

```markdown
---
name: platform-invoicing
description: "Use when the user asks anything about the invoicing tool: invoices, customers, payments, exports or a failed sync."
---
```

The description is the trigger. The engine shows every skill's name and description to the agent, and the agent opens the full skill when a request matches. So write the description the way people actually ask, with the main use first: engines may cut long descriptions. The rest of `SKILL.md`, the method itself, is read only when the skill is used. The agent carries a one-line map of every ability and opens only the one it needs.

A skill holds some mix of four things: a step-by-step method for one job, knowledge of one tool or service, rules of one domain, and scripts, references or templates that do the repetitive parts.

## The four living files

```text
skills/<name>/
├── SKILL.md       the method; works on any agent, on any machine
├── CONTEXT.md     the local half: paths, accounts, ids, business specifics
├── LEARNINGS.md   dated lessons from real runs
├── LOGS.md        run history: when, what started it, what happened
├── scripts/       optional: code for the mechanical steps
├── references/    optional: detail read only when needed
└── assets/        optional: templates and files used in the output
```

Each file has one job, and together they let a skill improve with use:

- `SKILL.md` stays portable. Ask of every line: would it be different on another agent? If yes, it goes to `CONTEXT.md`. Paths, channel ids, where a credential is kept, business names: all `CONTEXT.md`.
- `LEARNINGS.md` is how the skill gets better. A run that finds a pitfall writes it down, and the next run reads it before starting.
- `LOGS.md` shows what the skill actually did. It is history, not instruction; a run reads only its last few entries.
- When a run proves a file in the skill wrong, the agent fixes the file and records in `LEARNINGS.md` what was wrong, what it found and what it changed. An unrecorded fix is a silent fork: this copy improves, every other copy stays broken, and nobody can merge what nobody wrote down.
- When `LEARNINGS.md` passes about ten entries, merge it: move each proven lesson into `SKILL.md` or a reference, drop the lessons time disproved, keep a copy of the old file in the archive, then clear it.

One skill has exactly one `SKILL.md`. A large skill keeps one `SKILL.md` as a router and puts its branches in `references/`. Never put a skill inside another skill. Every skill ends with the same short block: what to read before a run, what to write after it. The template has it: [templates/skill/](../templates/skill/).

## Prefixes

A prefix at the start of a skill's name says what kind of skill it is. Prefixes help in a large library; they are labels, not law, and a skill without one still works.

| Prefix | Kind | Example |
|---|---|---|
| `core-` | shared thinking abilities used on demand: planning, research, systems thinking | `core-roadmap` |
| `platform-` | everything the agent knows about one outside tool or service | `platform-invoicing` |
| `tool-` | produces a result the person asks for: a report, a drawing, a draft | `tool-meeting-notes` |
| `system-` | owns the method for one kind of work and uses smaller skills for each part | `system-design` |
| `upkeep-` | keeps the agent's own machinery running, on request | `upkeep-restart` |
| `wf-` | a scheduled workflow, started only by its schedule | `wf-git-backup` |
| `cd-` | a command the person asks for by name | `cd-save` |

The scheduled upkeep jobs are `wf-` skills ([upkeep.md](upkeep.md)). `upkeep-` is for machinery work the agent does when asked.

## Where skills live

Every skill lives once, in the workspace's `skills/` folder. Each engine looks for skills in its own place: Claude Code in `.claude/skills/`, Codex in `.agents/skills/`. Do not copy skills there. Link those folders to `skills/`, so every engine sees the same files and a lesson learned on one engine is there for the other. Agent Bridges makes these links when it is installed. Without the bridge, see [Claude Code](../adapters/claude-code.md) and [Codex](../adapters/codex.md).

## How the agent finds a skill

Three ways work together:

1. The engine's own list. Every skill's name and description is in the agent's context; a matching request opens the skill. This is the main way.
2. `SKILLS.md`, the readable index at the root. It is a boot file, so the agent sees the whole library at every turn, including skills it would not think of from the current request. It is generated from the skill folders, never edited by hand ([boot-files.md](boot-files.md)).
3. A pointer line in a boot file: "For X, read skills/<name>/SKILL.md and follow it." This works on every engine. Use it for the few skills that must always load.

A skill the person names is a command, not a suggestion: the agent uses that skill, not a substitute. Reading a skill does not create access: a platform skill says how to use a tool, and `TOOLS.md` says whether that tool is connected.

## Scheduled workflows are wf- skills

A job that runs on a schedule is a `wf-` skill plus a schedule plus one place to report. The schedule holds one line: "Read skills/wf-<name>/SKILL.md and execute it." All behavior lives in the skill, so changing a workflow means editing one obvious file. A `wf-` skill's description says only "Scheduled workflow. Runs only from its scheduled job; not for conversational use.", so a conversation never starts it by accident. Every report starts with one status icon and ends with a line naming the skill file to edit. The jobs, how to schedule them and the reporting rules are in [upkeep.md](upkeep.md).

## Commands are cd- skills

Commands such as save, checkpoint or create project are `cd-` skills the person asks for by name. The list, and when each still helps, is in [upkeep.md](upkeep.md#on-demand-commands).

## Changing skills on purpose

- New skills come from the person. The agent does not propose a new skill each time it notices a pattern; it creates one when the person asks for it or accepts the design.
- A running skill improves itself through `LEARNINGS.md`, as above.
- Rename, merge or retire a skill deliberately, and update every place that names it: `SKILLS.md`, schedules, pointer lines. To retire a `wf-` skill, remove its schedule first, so nothing fires at a missing file.
- A skill from outside is untrusted until inspected. Read it without running it, and install it only with the person's yes ([workspace.md](workspace.md#untrusted-sources)).

Skill Forge is a separate product: a skill that creates, audits, merges and retires skills by this method. It helps once the library grows. The method on this page works without it.

## A quick check for any skill

1. Ask for the job the way a person would. The skill opens.
2. Run one real task and compare the result with a good one.
3. `SKILL.md` holds no local path, id or business name.
4. No file in the folder holds a secret.
5. One paragraph is one line: no line is broken by hand in the middle of a sentence.
6. After the run, `LOGS.md` has a new entry.

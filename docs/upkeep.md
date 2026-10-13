# Upkeep

Agents do not tidy up on their own. Left alone, a workspace drifts within weeks: stray files pile up at the root, decisions stay stuck in old conversations, the board stops saying what is happening, and nothing is backed up. Upkeep is a small set of background jobs that keep the workspace clean, current and safe while the person and the agent do real work. This page lists every job, then the commands the person can still ask for by hand.

## You never have to say "save"

Older setups depended on the person typing "save" at the end of each session. When they forgot, the session's decisions were lost. This method does not depend on anyone remembering. Three things make sure of it:

1. Saving while working is a rule. `WORKSPACE.md` tells the agent to write each decision, result and next step into the owning project's files as it happens, to add a line to today's daily file, and to commit the files it changed, by exact path, at each meaningful step. The project file is the truth; the conversation is only a log.
2. The nightly harvest catches what a conversation left out. Every night it reads the day's conversations where the engine or the bridge keeps them, saves any decision that never reached a file, writes the day's summary and rebuilds the board.
3. The weekly memory reflection moves lasting facts and lessons to their permanent homes.

The save command still exists for the moments when a handoff helps ([below](#on-demand-commands)). It never runs by itself, and nothing breaks when nobody uses it.

## How a background job works

Every background job is a workflow: a `wf-` skill, plus a schedule, plus one place where it reports.

- The skill holds all the behavior. The schedule holds one line: "Read skills/wf-<name>/SKILL.md and execute it." To change what a job does, edit its skill, never its schedule.
- Each job reports in exactly one place, chosen with the person: usually its own chat channel named after the job, sometimes a file. Every report starts with one status icon: ✅ ran clean, ⚠️ needs a look, ❌ failed. It ends with the file to edit: 📋 `skills/wf-<name>/SKILL.md`: edit this file to change behavior. A column of reports can then be scanned by its left edge, and feedback on a report goes straight to the right file.
- Mechanical steps (copy, count, commit, push) run as scripts that stop with an error when they cannot prove their work. The model is used only where judgment is needed, such as what a decision means and where it belongs.
- A job counts as working only after one run by hand produced the result written down as a good run. "The scheduler says it ran" proves nothing: a run can finish green and do nothing useful.
- One job per workflow, named after its skill folder. Delete a job you switched off, rather than leaving it behind. Give every job the person's time zone.

There are two ways to schedule jobs. Keep one, never both for the same job.

- With [Agent Bridges](../adapters/agent-bridges.md), recommended: the agent keeps its own job list and manages it with `agent-bridges job add`, `list`, `edit`, `pause`, `run-now` and the rest; `agent-bridges job help` is the full guide. A turn job wakes the agent in a channel with the one-line pointer. A script job runs a command without the model and posts its output. Use a script job when a workflow needs no judgment, such as the backup. Jobs run even when nobody writes.
- Without the bridge, the server's own scheduler (cron or a systemd timer) runs `claude -p "Read skills/wf-<name>/SKILL.md and execute it"` or `codex exec "Read skills/wf-<name>/SKILL.md and execute it"` from the workspace folder. The skill then posts its own report.

## The minimum set

Install these on day one; the Discord cleanup only if you use Discord. Times are suggestions in the person's time zone. The order matters more than the times. The skill names are suggestions too.

| Job | What it does | How often | Reports to |
|---|---|---|---|
| Workspace tidy (`wf-workspace-hygiene`) | Moves stray files from the root and from temporary folders to their project or resource folder, keeps only boot files at the root, adds missing index lines. Moves and renames; never deletes content. | daily, about 02:10 | its own channel, every run |
| Backup (`wf-git-backup`) | Commits the workspace changes that are safe to keep and pushes them to a private Git repository the person owns. Refuses anything that looks like a secret. Only a backup: it does no other repair. | daily, about 02:50 | its own channel, every run |
| Nightly harvest (`wf-knowledge-harvester`) | Reads the day's conversations where the engine or bridge keeps them, and the day's files and commits. Saves decisions that never reached a file into the owning project or space, writes the day's summary in the daily file, and rebuilds the `MEMORY.md` board from it. Commits and pushes its own changes. | daily, about 03:15 | its own channel, every run |
| Weekly memory reflection (`wf-memory-reflection`) | Moves lasting facts and lessons from the daily files into `USER.md`, `RULES.md`, `TOOLS.md`, skills, spaces and projects, without duplicates. Moves old daily files to `memory/archive/YYYY-MM/`. Rebuilds the board to its specification. | weekly, Sunday about 04:30 | its own channel, every run |
| Discord channel cleanup (`wf-discord-channel-cleanup`) | Keeps the server under its channel cap. Saves a full copy of a channel (messages and files) before deleting it, test channels first, then the longest inactive. A channel it cannot fully save stays. | daily, about 03:20, once the server passes a few hundred channels | its own channel, every run |

The backup runs before the harvest, so the harvest starts from a committed workspace. The tidy runs before the backup, so the backup saves a clean workspace. The reflection runs once a week, away from the nightly jobs. The channel cleanup and its rules are explained in [discord.md](discord.md).

The harvest reads conversations where they already are and routes decisions to their files. It is not a search engine over memory and not a diary written from chats. Where the engine or bridge cannot give it the day's conversations, the save-while-working rule and the weekly reflection do this work on their own.

## Recommended once the agent is in daily use

| Job | What it does | How often | Reports to |
|---|---|---|---|
| Job audit (`wf-job-audit`) | Checks that every job, its skill and its report channel still match. Finds switched-off, failing, silent or duplicate jobs. Changes nothing: every fix is the person's decision. | monthly, on the 1st | its own channel |
| Security check (`wf-security-audit`) | Read-only check of the server: login settings, open ports, firewall, pending updates, rights on credential files. Says what changed since last week. | weekly, Monday morning | its own channel |
| Storage check (`wf-storage-check`) | Watches the disk and says where growth comes from before the disk fills. Deletes only kinds of files the person approved as safe to rebuild. | daily, about 01:40 | its own channel |
| Snapshot check (`wf-snapshot-check`) | Checks that the server's snapshots or the hosting provider's backups exist and are fresh. | daily, in the morning | its own channel |

## Jobs the bridge already runs

Agent Bridges installs tested engine updates itself every week and restarts quietly when no answer is running ([Agent Bridges](../adapters/agent-bridges.md)). Do not add a second updater for the same engine. If your engine's login expires on a fixed date and nothing renews it, add a small check that warns well before it does. The guide's own version is a separate matter ([update.md](update.md)).

## The agent's own jobs

Beyond upkeep, the agent keeps jobs for real work: a weekly sales summary, time logging, an invoice reminder. They follow the same rules: a `wf-` skill for anything that repeats, one report place, the icon first and the file to edit last. The agent can also set itself a one-time follow-up, such as "check the delivery tomorrow at 09:00". It promises to come back later only when such a job is really set.

## A night in order

```text
01:40  storage check
02:10  workspace tidy
02:50  backup
03:15  nightly harvest
03:20  Discord channel cleanup
04:30  memory reflection (Sundays)
08:15  security check (Mondays)
10:00  job audit (the 1st of each month)
```

The author's own workspace runs this list, plus a few business jobs: [examples/reference-workspace.md](../examples/reference-workspace.md).

## On-demand commands

These are `cd-` skills the person asks for by name, in plain words ("save", "checkpoint"). None of them is needed to keep the workspace saved. Each still helps at a particular moment.

- **Save** (`cd-save`): ends a block of work. Updates the project files and today's daily file, records lessons in the skills they belong to, lists what was left unfinished, commits by exact path and writes a short prompt a new conversation can use to pick up. Useful before a long break, when a conversation has grown very long, or when the work passes to another agent.
- **Checkpoint** (`cd-checkpoint`): a quick save in the middle of work, without ending it. Updates `STATE.md` and today's daily file, then commits. Useful in a long build, or before a risky step.
- **Resume** (`cd-resume`): starts a new conversation where the last one stopped, from a save prompt or from the project files. Useful in a fresh conversation about older work, although the boot files and the project's `STATE.md` are usually enough.
- **Create project** (`cd-create-project`): creates `projects/<name>/` from the template, with a truthful `README.md`, `STATE.md` and `LOGS.md`, and a roadmap package only when asked. Useful whenever new bounded work starts, so it starts in the right shape.
- **Close project** (`cd-close-project`): records the project's final state, moves it to `archives/projects/`, adds one line to `archives/DONE-LOG.md` and commits. Useful when work is finished, so the active work stays easy to see.
- **Process content** (`cd-process`): files a transcript, video, article or note in the right `resources/` folder, with a date-first name, frontmatter and an index line. Useful whenever the person pastes or shares something worth keeping.
- **Close channel** (`cd-close-channel`): saves everything, writes a summary of the channel into the owning project, then deletes the channel. Only on the person's explicit request. Useful when a channel's work is done.

If the workspace does not have one of these skills yet, the agent can write it from the [skill template](../templates/skill/) the first time the person needs it. The line above is its purpose.

## Installing upkeep

[START-HERE.md](../START-HERE.md) walks through the setup. For each job, the agent:

1. Creates the `wf-` skill from the [skill template](../templates/skill/).
2. Writes down what a good run produces: which files change, what the report says.
3. Agrees the report place with the person and records it in the skill's `CONTEXT.md`.
4. Adds the schedule with the one-line pointer, in the person's time zone.
5. Runs the job once by hand and compares the result with the good run.

The backup needs a private Git repository that the person owns. Prove it by recovering one harmless file from that copy. Then run [verify.md](verify.md).

A job that is not installed, or not proven yet, is reported as "not installed" or "not proven". The agent never calls a job working because a file or a schedule exists.

## What upkeep does not do

Upkeep keeps plain files in order. It adds no search by meaning over memory and no diary written from chats.

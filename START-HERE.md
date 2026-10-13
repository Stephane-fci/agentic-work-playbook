# Start here

This page is for the agent. If you are a person, read [README.md](README.md) and give your agent the sentence it shows.

## Your role

You are the teacher and the implementer for your person. You set yourself up with this guide and explain each step in plain words as you go, so your person understands what they have at the end. Explain the way you would to a smart friend who never thought about it, at the depth they want: some want only the result, some want to know how it works.

This page is the route. The method lives in [docs/](docs/). Read each page when its step comes, not all at once.

Keep your copy of this guide out of the top of the workspace, where every Markdown file becomes part of your instructions: beside the workspace, or in `resources/repositories/` ([docs/workspace.md](docs/workspace.md)).

## Rules of engagement

1. Inspect before you write. Look at what exists before you create anything, and reuse what the files already say.
2. Never overwrite your person's own files. Complete them: add what is missing, keep what is there.
3. On a workspace already in use, show the list of changes first: each file to create, to complete or to leave alone, in plain words. Apply nothing before your person's yes.
4. Ask only questions whose answer changes the result, and ask them together in one short batch. Never ask what the files can tell you.
5. No secrets in files. A password or key goes to a protected place outside the workspace, and TOOLS.md says only where it is kept ([docs/workspace.md](docs/workspace.md#credentials-never-live-in-the-workspace)).
6. Finish every step and report it. A step is done when its check passes. A step you cannot finish is written down as open, with what it waits for, and you go on with the steps that do not depend on it. Never call setup done while a step is open.
7. A second run of the setup adds only what is missing: never a second copy of an import line, a link or a job.

For every step: say in one sentence what it does and why, do it, check it, then tell your person the result with the step's closing sentence, adapted to what really happened.

## Step 1: Read the method

Read [docs/way-of-working.md](docs/way-of-working.md) in full: it is the reason behind every other step. Look at [examples/personal-assistant/](examples/personal-assistant/) to see where the setup ends.

What to tell your person: "I read the guide: everything I learn about you and your work will live in plain files, so I remember from one conversation to the next."

## Step 2: Inspect what exists

Change nothing yet. Find out:

- The workspace folder, and whether it is new or already in use.
- Your engine and its version, and whether Agent Bridges runs you (`sudo agent-bridges doctor`).
- The Markdown files at the top, which boot file each one matches, and what they already say about you and your person.
- The folders, connected tools and work in progress.
- Whether the folder is a Git repository (Git keeps its version history) with a private online copy.
- Scheduled jobs that already run: `agent-bridges job list`, or the server's own scheduler.
- Any other agent that writes here, or prepares files for this folder from another machine.

One writer per file. When another agent works here, agree with your person which files each agent owns before anyone writes ([docs/way-of-working.md](docs/way-of-working.md#one-writer-per-file)). An agent preparing files on another machine never copies its starter files over the live workspace.

The read-only check of step 9 shows the gaps now too ([checks/README.md](checks/README.md)). Sum up what exists, what is missing and what belongs to someone else.

What to tell your person: "I looked at what you already have: {one-line summary}. I will keep all of it and only add what is missing."

## Step 3: Choose the profile

Choose one of the [three profiles](docs/boot-files.md#three-profiles): your person's own assistant (the default), a team assistant, or a specialist, and note whether you work as a second operator beside an existing agent. Decide from what step 2 found; ask only when the files cannot tell. Team assistant: [examples/team-assistant/README.md](examples/team-assistant/README.md).

What to tell your person: "I will set myself up as {your own assistant, your team's assistant, a specialist for one job}, because {reason}."

## Step 4: Interview your person

Ask only what the files cannot tell, in one batch, saying in a few words why each question matters. The usual gaps: your name and role; their name, time zone, work and how they like answers; what needs their yes (sending, spending, publishing, deleting); the first tools to connect; where job reports go; whether they use Discord; for a team, who may ask for what.

Use their own words. An unknown fact stays visibly unknown as `{unknown: ask}` ([docs/boot-files.md](docs/boot-files.md#writing-boot-files-well)).

What to tell your person: "I have a few questions only you can answer; everything else I found in your files."

## Step 5: Create or complete the workspace

Uses [docs/workspace.md](docs/workspace.md), [docs/boot-files.md](docs/boot-files.md) and the [templates/](templates/) for root files, projects, spaces, resources and daily memory.

1. On a workspace already in use, show the list of changes and wait for the yes (rule 3).
2. Make every change undoable. Not a Git repository yet? Run `git init` and commit what exists, as it is. Already one? Write down `git rev-parse HEAD`: that is [the way back](docs/update.md#the-way-back).
3. Create the setup project `projects/agent-setup/`. Its STATE.md says which step is done and what comes next, so a new conversation can continue the setup.
4. Create the folders that are missing. Add `repositories/` and `dashboards/` only when there is code or a running app.
5. Copy WORKSPACE.md, OPERATING-MODE.md and COMMUNICATION.md whole. Where the workspace has its own version, propose a merge instead ([docs/update.md](docs/update.md#three-kinds-of-file)).
6. Write SOUL.md, IDENTITY.md, USER.md, RULES.md and TOOLS.md from the interview and the files. Start MEMORY.md, today's daily file, and SKILLS.md generated from `skills/`.
7. Create one space per client or area your person named, and one resources folder per kind of material, each with its INDEX.md.

Finish your own files before you call setup done. A boot file still holding template guidance is a starter: `grep -n "Template:" *.md` at the top of the workspace must print nothing, and the only braces left are `{unknown: ask}`. Short true versions are enough now; complete TOOLS.md and SKILLS.md after steps 6 and 7.

"Not allowed" in TOOLS.md lists only what your person really forbids. Never forbid yourself your own settings: an agent that cannot read its bridge settings cannot change its own name, picture or channels.

What to tell your person: "Your workspace is ready: I created {number} files, completed {number} and left your own files as they were. Here is the list."

## Step 6: Connect the engine

Pick the adapter: [Agent Bridges](adapters/agent-bridges.md) (recommended), [Claude Code](adapters/claude-code.md) or [Codex](adapters/codex.md) without the bridge, or [OpenClaw](adapters/openclaw.md) for an existing OpenClaw agent. Templates: [AGENTS.md](templates/root/AGENTS.md) and [CLAUDE.md](templates/root/CLAUDE.md).

1. Write AGENTS.md and CLAUDE.md from their templates ([docs/boot-files.md](docs/boot-files.md#engine-connection-files)). Complete an existing one; never replace it.
2. Link the skills folder where your engine looks for skills, unless the bridge already did ([docs/skills.md](docs/skills.md#where-skills-live)).
3. With the bridge, add today's and yesterday's daily files and, beside another agent, leave out that agent's identity files ([adapters/agent-bridges.md](adapters/agent-bridges.md#the-two-settings-this-guide-uses)).
4. Without the bridge, tell your person the limit: a changed instruction file counts from the next new conversation.
5. Run the check at the end of your adapter page.

A starter AGENTS.md or CLAUDE.md, or a skills folder your engine cannot see, means this step is not done.

What to tell your person: "I now read all my instruction files fresh at every message, so any change you make counts from your next message." Without the bridge, say "at the start of every new conversation" instead.

## Step 7: Install upkeep

Uses [docs/upkeep.md](docs/upkeep.md) and [templates/skill/](templates/skill/). Install [the minimum set](docs/upkeep.md#the-minimum-set) by the steps in [Installing upkeep](docs/upkeep.md#installing-upkeep). The backup needs a private online copy your person owns; help them create one if needed, and keep its key out of the files (rule 5).

Install the jobs for real, and show one real run. A skill file or a schedule is not a working job. A job counts only after one run by hand produced its good result and its report landed in the agreed place: show that report to your person. For the backup, fetch one harmless file back from the copy. A server snapshot is not a workspace backup. If your person wants to wait, write "not installed" in the setup project and the final report.

What to tell your person: "Every night your workspace now tidies itself, saves what our conversations decided and backs itself up. Here is the first report."

## Step 8: Discord (optional)

Only when your person works with agents in Discord. Otherwise write "Discord: not used" and go to step 9. Uses [docs/discord.md](docs/discord.md) and the "Discord: how we work" section of [templates/root/RULES.md](templates/root/RULES.md).

Get the chat rights sorted first. Renaming channels and creating categories need Discord's Manage Channels permission for your bot; check it before any Discord work. A bot cannot raise its own role: only the server owner can, under Roles in the server settings, or by inviting the bot again. Until then, propose names but change nothing.

1. Build the bucket list with your person ([docs/discord.md](docs/discord.md#build-your-own-bucket-list)) and write the legend into RULES.md.
2. Rename and sort only after your person approved the list of current and new names ([docs/discord.md](docs/discord.md#changing-names-safely)).
3. Ask which channels are private, and check who can see each one. Every member sees a channel unless it is made private; a name like "personal" hides nothing.
4. Add the channel cleanup job from step 7 once the server holds a few hundred channels.

What to tell your person: "Your channels now start with an emoji that says what kind of work each one holds, and the legend sits in my rules, so every agent knows it."

## Step 9: Run the checks

1. Run `bash checks/check-workspace.sh /path/to/workspace` from the guide's folder ([checks/README.md](checks/README.md)). Fix every line that says FIX and run it again. Read every WARN line. The warning about the missing installed receipt is expected until step 10.
2. Work through [docs/verify.md](docs/verify.md) in order: the loading check, the six questions, then upkeep and backup. A test that needs a fresh conversation runs in a new one; ask your person to open it when you cannot. Only [real proof](docs/verify.md#what-counts-as-proof) counts.
3. Look once more for template lines left in boot files (step 5) and jobs not yet proven (step 7).

What to tell your person: "I tested myself with real checks instead of taking my own word for it. Here is what passed."

## Step 10: Record and report

1. Write `.playbook/installed.json` as [docs/update.md](docs/update.md#the-installed-receipt) says: the version from [VERSION](VERSION), the date, and every file the guide installed with its source, class and hash.
2. Run `checks/check-workspace.sh` once more. The receipt line now passes, and no line says FIX.
3. Commit only the files the setup touched, by exact path.
4. Write the report in [three parts](docs/verify.md#how-to-report): what works, with its proof; what was not checked, and why; the next action. Save it in the setup project's LOGS.md and set its STATE.md to that next action. When nothing is left, archive the project.
5. Tell your person how to update later: "Update the playbook by following docs/update.md."

What to tell your person: "Setup is finished. {What works}. Not checked: {what, and why}. Next: {one action, or nothing for you to do}."

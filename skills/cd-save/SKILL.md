---
name: save
description: "End-of-session save. Use when the user says /save, asks to wrap up, save everything, create a handoff, or prepare a resume prompt."
---

# /save

End the session cleanly by transferring volatile context into durable files. The next agent should be able to run `/resume` and continue without asking the user to reconstruct what happened.

## Standard

A save is complete only when:

1. Current state is written to the right files.
2. Reusable learnings are routed to the right skill or knowledge file.
3. Unfinished tasks are listed clearly.
4. Workspace changes are committed to Git when appropriate.
5. A copyable resume prompt or handoff is produced.

## Before execution

Read these files in this skill directory:

1. `CONTEXT.md` for local configuration.
2. `LEARNINGS.md` in full for accumulated save lessons.
3. The last ~2000 characters of `LOGS.md` for recent save history.

Also inspect the active project/space files before editing them.

## Phase 1 — Identify scope

Determine what the session was about:

- Active project work.
- Long-term space/domain work.
- Tool or skill setup.
- General conversation or planning.
- External actions or platform operations.

If the scope is unclear, inspect recent files, Git status, and available session history before asking the user.

## Phase 2 — Save state

### If working on a project

Update the project's `ROADMAP.md`:

- Current status.
- Completed work.
- Decisions made.
- Blockers.
- Next step.

Update any project entry point if one exists, such as `AGENT.md`, `README.md`, or a project brief.

### If working in a space

Update the space's `MEMORY.md` and, if priorities changed, `ROADMAP.md`.

### Always consider

- Root `MEMORY.md` if the state affects current priorities.
- `memory/YYYY-MM-DD.md` for the daily log.
- `TOOLS.md` if tools, credentials, APIs, or gotchas changed.
- `USER.md` if durable user preferences or facts changed.
- `WORKSPACE.md` if the file structure changed.

## Phase 3 — Capture reusable learnings

Ask: what did this session teach that will matter later?

Route learnings like this:

| Learning type | Destination |
|---------------|-------------|
| Skill/process improvement | Related skill's `LEARNINGS.md` |
| Tool/API gotcha | Related platform/tool skill, or `TOOLS.md` if no skill exists |
| User preference/fact | `USER.md` or root `MEMORY.md` |
| Domain/client knowledge | Relevant `spaces/<name>/MEMORY.md` or knowledge file |
| Project-specific decision | Project `ROADMAP.md` |

Capture only durable, reusable, non-obvious knowledge. Do not bloat files with noise.

## Phase 4 — Clean temporary files

Inspect likely scratch locations:

- Workspace root.
- `tmp/` or runtime scratch folders.
- Newly created scripts or artifacts.
- Downloaded/generated files.

Move valuable files to the correct location. Delete only obvious scratch/cache files. When unsure, archive instead of deleting.

## Phase 5 — Capture unfinished work

List anything discussed but not completed:

- Open tasks.
- Pending decisions.
- Blockers.
- Follow-up checks.
- Files or systems that still need verification.

Do not silently create external tasks unless the user explicitly asked for that. The save output itself must make unfinished work visible.

## Phase 6 — Commit

Inspect Git status before committing. Do not blindly stage unrelated changes from other sessions or background jobs.

Recommended pattern:

```bash
git status --short
git add <files-that-belong-to-this-save>
git commit -m "Save: <brief description>"
git push
```

If unrelated dirty files exist, leave them unstaged and mention them in the save output.

If Git is not available or no files changed, say so plainly.

## Phase 7 — Produce handoff

Generate a concise handoff with:

- What was saved.
- Files updated.
- Skills/learnings updated.
- Open items.
- Exact next step.
- Copyable `/resume` prompt.

The `/resume` prompt should list the files the next session must read, including project/space files and recent memory.

## Output format

Use this structure:

```text
Saved.

Updated:
- ...

Open:
- ...

Next step:
...

Resume prompt:
/resume ...
```

Keep it compact. Do not dump the entire session unless the user requested a full archive.

## Self-improvement

After execution:

1. Append to `LOGS.md` with trigger, scope, files updated, commit hash if any, and outcome.
2. Append durable save-process discoveries to `LEARNINGS.md`.
3. Update `CONTEXT.md` if local save behavior, paths, or Git conventions changed.

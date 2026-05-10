# AGENTS.md — Boot Loader

You start every session with no reliable memory. The workspace files are your memory. Read them before doing real work.

## Boot gate

Before answering the user's real request, read these files fully, in order:

1. `SOUL.md`
2. `IDENTITY.md`
3. `RULES.md`
4. `USER.md`
5. `WORKSPACE.md`
6. `TOOLS.md`
7. `MEMORY.md`
8. `SKILLS.md`
9. Today's `memory/YYYY-MM-DD.md`, if it exists
10. Yesterday's `memory/YYYY-MM-DD.md`, if it exists

Injected context does not count. Prior memory does not count. Partial reads do not count.

If a required root file is missing, report it plainly and create it only with approval. Missing daily memory files are not blockers.

## After boot

1. Check active work by reading `projects/*/ROADMAP.md`.
2. Check whether any background sessions/tasks are running, if your runtime supports it.
3. Give the user a compact status and the next useful move.

## Skill rule

Before multi-step work, check `SKILLS.md`. If a skill clearly applies, read its `SKILL.md` and follow it.

## Save rule

When work changes files or decisions, update the relevant project/space file, update memory if needed, then commit to Git.

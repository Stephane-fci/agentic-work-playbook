# Context — cd-save

Portable save-command skill for file-backed agents.

## Default paths

- Root memory: `MEMORY.md`
- Daily memory: `memory/YYYY-MM-DD.md`
- Active projects: `projects/*/ROADMAP.md`
- Spaces: `spaces/*/MEMORY.md` and `spaces/*/ROADMAP.md`
- Skills: `skills/*/LEARNINGS.md` and `skills/*/LOGS.md`

## Git

Use Git if the workspace is a Git repo. Always inspect `git status --short` before staging.

Stage only files that belong to the save. Do not sweep unrelated dirty files into a save commit.

## External task managers

Do not create or modify external task cards by default. List unfinished work in the save output unless the user explicitly asks for external task updates.

# Changelog

## 2026-05-10 — v2.1.0 workspace + boot + skills refresh

Updated the repo to reflect the current production Agentic Work pattern.

### Added

- Root `WORKSPACE.md` with the current workspace blueprint.
- `BOOT-FILES.md` explaining how to create a proper boot-file set.
- `templates/root/` with starter boot files.
- `templates/project/ROADMAP.md`.
- `templates/space/` with `INDEX.md`, `ROADMAP.md`, and `MEMORY.md`.
- `templates/skill/` with `SKILL.md`, `CONTEXT.md`, `LEARNINGS.md`, and `LOGS.md`.
- `skills/skill-forge/` as a portable meta-skill for creating and maintaining skills.
- `skills/cd-save/` as a portable end-of-session save command.

### Changed

- README now frames the playbook as model/runtime agnostic: useful for OpenClaw, local Codex, Claude Code, or any file-backed agent.
- FRAMEWORK now points to the new current-status files before the older long-form sections.

### Notes

- Secrets and private workspace-specific context were intentionally not copied.
- `skill-forge/CONTEXT.md`, `LEARNINGS.md`, and `LOGS.md` were reset to generic portable versions.

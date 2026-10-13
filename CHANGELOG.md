# Changelog

The guide's version lives in [VERSION](VERSION). Each entry says what changed and why. How a workspace moves from one version to the next is in [docs/update.md](docs/update.md).

## 3.0.0 (October 2026)

A rewrite for agents on Claude Code and Codex, built from how Stephane Franceschini (Steph France) works with his own agents today. The method is the same at heart; the guide around it is new.

### Changed

- Engine-neutral. The guide targets Claude Code and Codex. The workspace, boot files, skills and memory work the same on both, and moving from one to the other keeps the workspace.
- Every boot file at every turn. Every Markdown file at the top of the workspace is read in full at every turn through Agent Bridges, not once at the start of a session, and the setup proves it ([docs/verify.md](docs/verify.md)).
- One 49 KB document became short pages with one job each: [START-HERE.md](START-HERE.md) for the agent's setup, `docs/` for the method, `adapters/` for each engine, `templates/` and `examples/` for the files, and `checks/` for a read-only structure check. FRAMEWORK.md, BOOT-FILES.md, the root WORKSPACE.md and UPDATE-PROTOCOL.md are replaced by these pages.
- Projects keep README.md, STATE.md and LOGS.md, with a roadmap package only when it helps; a ROADMAP.md is no longer required in every project. The workspace adds `repositories/` for owned code and `dashboards/` for records of running apps ([docs/workspace.md](docs/workspace.md)).
- Saving is part of the work. The agent writes decisions into project files as they happen, and scheduled upkeep catches the rest, so the person never has to say "save" ([docs/upkeep.md](docs/upkeep.md)).
- The agent acts within the authority it already has and asks only questions whose answer changes the result. Approval for every single change is gone.
- Context percentages in replies are gone: the agent reports context use only when the person asks.
- One version source. VERSION is the only place the version lives, and each workspace keeps an installed receipt, `.playbook/installed.json`. In 2.x the README announced 2.1.0 while the newest release was 2.0.0, so release-based update checks missed the May changes.
- The post-setup tick list became an acceptance check that asks for real proof ([docs/verify.md](docs/verify.md)).

### Added

- The Discord method, optional: one bucket emoji per kind of work at the start of every channel name, end marks for status, threads for side work and a separate category for tests ([docs/discord.md](docs/discord.md)).
- The full list of background upkeep jobs and on-demand commands ([docs/upkeep.md](docs/upkeep.md)).
- Filled fictional examples ([examples/](examples/)) and the read-only workspace check ([checks/](checks/)).
- A short note for existing OpenClaw workspaces ([adapters/openclaw.md](adapters/openclaw.md)).

### Removed, and why

- The OpenClaw-only setup (install, update, session settings and config pitfalls): the guide now targets Claude Code and Codex, and engine settings went out of date within weeks.
- HEARTBEAT.md: periodic work now runs as scheduled upkeep jobs, each one a skill, so a heartbeat checklist had nothing left to do.
- SUBAGENT-BOOT.md: guidance for helper agents now lives in OPERATING-MODE.md and each engine's own instruction file, so a separate boot file only repeated rules.
- The OpenClaw skill scanners in `scripts/` (`skill-audit` and `skill-install`): the rule that remains works on every engine: inspect an outside skill without running it, and install it only with the person's clear yes ([docs/workspace.md](docs/workspace.md)).
- The bundled skills (`skill-forge`, `cd-save`, `pil-diagrams`): copies inside the guide went stale. Skill Forge is now a separate product, saving is built into the rules and upkeep, and diagrams are not part of the method.

## 2.x summary

- 2.1.0 (May 2026): a workspace blueprint, a guide to boot files, templates for root files, projects, spaces and skills, and portable Skill Forge and cd-save skills. It was never published as a release, so agents that checked releases never saw it.
- 2.0.0 (February 2026): a complete rewrite for OpenClaw agents: spaces, projects, resources and archives; skill prefixes; credentials mapped in TOOLS.md and kept out of the workspace; scheduled workflows as skills; context management; a post-setup audit.
- Before 2.0 (February 2026): the first versions, one long OpenClaw guide that grew section by section.

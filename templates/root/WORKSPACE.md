# WORKSPACE.md — Agentic Workspace Blueprint

This is the default workspace structure for a file-backed AI agent. It works for OpenClaw, Codex, Claude Code, or any agent that can read and write local files.

## Why this exists

Agents do not have durable memory unless important context is written to disk. The workspace is the agent's brain. A clean workspace makes the agent useful; a messy workspace makes it hallucinate, lose context, and repeat mistakes.

The structure is built on three principles:

1. Every file type has one home.
2. Every session can boot from the same small set of root files.
3. Reusable knowledge becomes a skill instead of staying buried in a project.

## Root files

```text
~/agent-workspace/
├── AGENTS.md        → boot sequence and operating instructions
├── SOUL.md          → identity, ethics, boundaries, personality
├── IDENTITY.md      → name, vibe, communication style
├── RULES.md         → hard rules and safety constraints
├── USER.md          → who the agent helps
├── WORKSPACE.md     → this folder structure and routing logic
├── TOOLS.md         → tools, services, credential locations, no secrets
├── MEMORY.md        → current priorities and active threads
├── SKILLS.md        → capability registry
├── HEARTBEAT.md     → optional periodic check instructions
│
├── spaces/          → durable knowledge by client, life area, brand, or domain
├── projects/        → active temporary work containers
├── resources/       → reference material organized by type
├── skills/          → reusable capabilities
├── memory/          → daily session logs
└── archives/        → inactive/completed material, mirroring original paths
```

## spaces/

Use `spaces/` for long-term knowledge. A space might be a client, a business, a brand, a family area, a research domain, or a creative practice.

Every space should include:

```text
spaces/<space-name>/
├── INDEX.md         → what this space is and where to find things
├── ROADMAP.md       → current priorities, active questions, next moves
└── MEMORY.md        → durable activity log for this space
```

Use the template in `templates/space/`.

## projects/

Use `projects/` for active work that has a start and end. Every project must have a `ROADMAP.md`.

```text
projects/<project-name>/
├── ROADMAP.md       → status, decisions, next actions, blockers
└── ...              → project-specific files
```

When a project is done or inactive, move the whole folder to `archives/projects/<project-name>/` and log it in `archives/DONE-LOG.md`.

Use the template in `templates/project/`.

## resources/

Use `resources/` for reference material that is not itself an active project.

```text
resources/
├── conversations/   → call notes, meeting transcripts, chat exports
├── great-content/   → external articles, videos, podcasts worth saving
├── notes/           → research, brainstorms, general references
├── videos/          → the user's own video transcripts or scripts
├── diagrams/        → diagrams and visual references
└── scripts/         → standalone utility scripts
```

Prefer date-based names: `YYYY-MM-DD-short-description.md`.

## skills/

Use `skills/` for reusable capabilities. Projects are temporary. Skills are permanent.

```text
skills/
├── cd-*             → command skills, often user-triggered
├── wf-*             → workflow skills, often scheduled
├── system-*         → durable system/process knowledge
├── platform-*       → platform/API/tool-specific operations
├── ext-*            → external imports
└── <plain-name>/    → acceptable for simple local/Codex skills
```

Every skill should follow the template in `templates/skill/`:

```text
skill-name/
├── SKILL.md
├── CONTEXT.md
├── LEARNINGS.md
├── LOGS.md
├── references/      → optional
├── scripts/         → optional
└── assets/          → optional
```

## memory/

Use `memory/YYYY-MM-DD.md` for daily logs. These are the raw record of what happened.

Use root `MEMORY.md` for the curated current state: active priorities, unresolved questions, and important recent decisions.

## archives/

Archive instead of deleting. Preserve history unless the file contains secrets or private material that must be removed.

```text
archives/
├── DONE-LOG.md
├── projects/
├── spaces/
└── resources/
```

## Decision tree

```text
Behavior rule?                  → RULES.md
Agent identity or ethics?       → SOUL.md / IDENTITY.md
About the user?                 → USER.md
Tool/service/API info?          → TOOLS.md
Current priorities?             → MEMORY.md
Daily activity?                 → memory/YYYY-MM-DD.md
Long-term domain knowledge?     → spaces/<name>/
Active start-to-finish work?    → projects/<name>/
Reference material?             → resources/<type>/
Reusable procedure?             → skills/<name>/
Done or inactive?               → archives/...
```

If it does not fit, do not invent a new folder casually. Ask whether the structure needs to evolve.

## Credential rule

Never store API keys, tokens, passwords, private SSH keys, or recovery codes in the workspace. `TOOLS.md` stores the map to credentials, not the credentials themselves.

# Boot Files — How to Create an Agent Brain

Boot files are the small set of root files an agent reads at the start of a session. They give a fresh model enough identity, memory, rules, and tool knowledge to continue work without starting from zero.

This applies to OpenClaw, Codex, Claude Code, or any local agent workflow.

## The required boot files

Create these files in the workspace root:

```text
AGENTS.md
SOUL.md
IDENTITY.md
RULES.md
USER.md
WORKSPACE.md
TOOLS.md
MEMORY.md
SKILLS.md
HEARTBEAT.md
```

`HEARTBEAT.md` can be mostly empty if the runtime does not support heartbeat checks.

## Boot order

A robust agent should read files in this order:

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

After boot, the agent should check active projects by reading `projects/*/ROADMAP.md`.

## What each file does

### AGENTS.md

The boot loader. It tells the agent what to read, in what order, and what must happen before normal work begins.

Include:

- The exact boot sequence.
- A rule that injected context or memory is not enough. The files must be read explicitly.
- What to do if a required file is missing.
- How to check active projects.
- How to behave after compaction or session restart.

### SOUL.md

The agent's ethics and deeper personality.

Include:

- Honesty rules.
- Privacy boundaries.
- What the agent should optimize for.
- What kind of relationship it should have with the user.
- What failure modes to avoid.

Keep it stable. Changing this file changes the agent's character.

### IDENTITY.md

The lightweight identity layer.

Include:

- Name.
- Vibe.
- Signature emoji or style markers, if useful.
- Communication preferences.
- Any cultural/style notes.

### RULES.md

Hard operating rules.

Include:

- External action rules: ask before sending, deleting, publishing, buying, deploying, or making irreversible changes.
- File safety rules.
- Communication rules.
- Skill invocation rules.
- Git/checkpoint rules.
- Platform-specific formatting rules.

This file should be direct and non-negotiable.

### USER.md

The user model.

Include:

- Who the user is.
- What they do.
- Current goals.
- Communication preferences.
- Important people, clients, projects, constraints.
- Decision filters.

Do not turn this into a diary. It is the stable profile the agent needs to help well.

### WORKSPACE.md

The workspace map and routing logic.

Include:

- Folder structure.
- What belongs where.
- Naming conventions.
- Archive rules.
- Credential storage rules.

Use the root `WORKSPACE.md` in this repo as the default.

### TOOLS.md

The service and tool catalog.

Include:

- Tool name.
- What it does.
- Credential location, never the secret value.
- Access level.
- Setup status.
- Known gotchas.
- Related skill, if any.

### MEMORY.md

Current live context.

Include:

- Current priorities.
- Active threads.
- Recent important decisions.
- Open blockers.
- Anything the next session needs immediately.

Keep it small. Move durable domain knowledge to `spaces/` and raw history to `memory/YYYY-MM-DD.md`.

### SKILLS.md

The skill registry.

Include:

- Skill name.
- Trigger/use case.
- Short description.
- Location.

Before multi-step work, the agent checks this file to avoid improvising when a skill exists.

### HEARTBEAT.md

Optional periodic instructions.

Include only if the runtime supports periodic wakeups or scheduled checks. If not, keep a short note saying there is no heartbeat behavior.

## Boot file creation process

1. Start from `templates/root/`.
2. Fill `USER.md` first. The user's reality drives everything else.
3. Fill `SOUL.md` and `IDENTITY.md` next.
4. Fill `RULES.md` with safety and communication rules.
5. Copy or adapt `WORKSPACE.md`.
6. Fill `TOOLS.md` with only tools that actually exist.
7. Create empty `MEMORY.md`, `SKILLS.md`, and today's daily memory file.
8. Create `projects/_template/` and `spaces/_template/`.
9. Commit the initial workspace to Git.

## Quality bar

A fresh agent should be able to answer these after boot:

- Who am I?
- Who am I helping?
- What are my hard rules?
- Where do files go?
- What tools do I have?
- What are the current priorities?
- What skills exist?
- What project should I inspect next?

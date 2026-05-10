---
name: skill-name
description: "What this skill does and when to use it."
---

# Skill Name

## Purpose

What this skill helps the agent do reliably.

## When to use

Use this skill when:

- TODO

Do not use this skill when:

- TODO

## Before execution

Read these files in this skill directory:

1. `CONTEXT.md` for local configuration.
2. `LEARNINGS.md` in full for accumulated knowledge.
3. The last ~2000 characters of `LOGS.md` for recent execution history.

## Workflow

1. Clarify the requested outcome.
2. Inspect required inputs and tools.
3. Execute the smallest safe plan.
4. Verify the result.
5. Report outcome and next step.
6. Update `LOGS.md` and, if something was learned, `LEARNINGS.md`.

## Safety

- Do not expose secrets.
- Ask before irreversible or external actions.
- Prefer read-only inspection before writes.

## Self-improvement

After execution, append to `LOGS.md` with the trigger, actions, outcome, and duration.

If the skill learned something reusable, append to `LEARNINGS.md` with:

- What happened.
- What was learned.
- What should change next time.

---
name: skill-forge
description: "Create or update skills. Use when the user asks to create, improve, review, or audit a skill."
---

# Skill-Forge

The meta-skill for creating and maintaining self-improving skills.

Two modes: **CREATE** (build from scratch) and **UPDATE** (feed knowledge into an existing skill).

**Core principle:** Skills are living systems. They execute, they learn, they improve. Every execution makes the skill better for the next one.

---

## What is a Skill

A skill is a self-contained package that transforms a general-purpose agent into a specialized one. It provides procedural knowledge that no model fully possesses on its own — the specific workflows, tool integrations, domain expertise, and resources needed to handle a particular domain or task reliably.

**What skills provide:**
1. **Specialized workflows** — step-by-step procedures for specific domains (how to run market research, how to triage emails, how to generate ad creatives)
2. **Tool integrations** — instructions for working with specific APIs, file formats, or services
3. **Domain expertise** — business-specific knowledge, schemas, terminology, rules
4. **Bundled resources** — scripts for repetitive tasks, reference docs, templates, and assets

Without a skill, the agent relies on general knowledge and improvises. With a skill, it follows proven procedures, avoids known pitfalls, and benefits from accumulated experience.

---

## The Skill Standard

Every skill follows this structure:

```
skill-name/
├── SKILL.md           # Universal core — portable, changes documented in LEARNINGS.md
├── CONTEXT.md         # Business/agent-specific — local tools, paths, use cases
├── LEARNINGS.md       # Append-only knowledge from executions
├── LOGS.md            # Execution history — what ran, when, outcome
├── scripts/           # Executable code (optional)
├── references/        # Detailed docs loaded on demand (optional)
└── assets/            # Files used in output: templates, images, fonts (optional)
```

### SKILL.md — The Universal Core

The brain of the skill. Contains all instructions, workflows, and principles needed to execute. Written so that any agent on any system can read it and do the job.

**Rules:**
- 100% portable. No hardcoded paths, no business names, no agent-specific references.
- Can be modified by the agent when improvements are needed — but every change must be documented in LEARNINGS.md.
- Keep it concise. The context window is shared — move detailed material to `references/` when sections grow long.
- Written in imperative form ("Generate the report", not "You should generate the report").
- Must include the Philosophy of Self-Improvement section (see below).
- Must instruct the agent to read CONTEXT.md, LEARNINGS.md, and LOGS.md before every execution.

### CONTEXT.md — The Local Configuration (MANDATORY)

Where all business-specific, agent-specific, and environment-specific details live. Each agent running the skill has its own version. **Reading CONTEXT.md is mandatory before every execution — not optional.**

Contains things like:
- Credential paths and API references
- Discord channel IDs, guild IDs, reporting targets
- Workspace paths and tool locations
- Business-specific examples and edge cases
- Links to related skills or resources in the local workspace

**The extraction rule:** "Would this line be different on another agent?" If yes, it MUST go in CONTEXT.md, not SKILL.md. SKILL.md must be 100% portable — if you dropped it on a brand new agent with no history, the universal instructions should make sense. Everything that connects the skill to a specific environment (credentials, channels, paths, tools) belongs in CONTEXT.md.

This is what makes the same universal skill work differently in different environments. An email triage skill works the same way everywhere — but on one agent, emails are from German-speaking customers and responses must be in German, while on another they're in English. That's a CONTEXT.md difference.

### LEARNINGS.md — Institutional Memory

Append-only. After every execution, the agent writes what it learned — what worked, what failed, what surprised. Entries are dated.

```markdown
## 2026-03-21 — Copyright filter workaround
When Gemini blocks character names, describe visual traits instead.
"blue alien creature, big round head, large ears" instead of "Stitch."

## 2026-03-17 — Batch generation rate limits
Account gets flagged after ~30 rapid requests. Space out with 2s delays.
```

Learnings are never deleted by the agent. They accumulate until the human reviews them across all agents, merges the best improvements into the canonical skill version, and clears the file to start a new cycle.

Learnings also serve as a changelog when the agent modifies skill files directly. Every modification to SKILL.md, references, or scripts must have a corresponding LEARNINGS.md entry documenting what changed and why.

### LOGS.md — Execution History

Records what happened each time the skill ran. Factual, not analytical.

```markdown
## 2026-03-21 14:30

- **Trigger:** User asked to generate product mockups
- **Actions:** Generated 4 images, 2K resolution, --thinking high
- **Outcome:** 3 successful, 1 blocked by content filter
- **Duration:** ~60s
```

Logs are agent-local and are never deleted or trimmed — they are the full execution history. When reading before execution, only the last ~2000 characters are needed for context. The rest stays as a permanent record for debugging and usage analysis.

---

## The Philosophy of Self-Improvement

Skills are not static documents. They are living systems that get better every time they run.

### Why This Matters

A skill that has been executed 100 times should be dramatically better than when it was first written. Not because someone manually rewrites it, but because the system is designed to capture knowledge from every execution.

Most skills start as "good enough" instructions. Over time, the agent discovers:
- Edge cases the author didn't anticipate
- Better approaches that emerge from practice
- Failure patterns that need workarounds
- Tool-specific behaviors that aren't documented anywhere

Without a system to capture these, every discovery is lost at the end of the session. The next time the skill runs, the same mistakes repeat. This is what the self-improvement system prevents.

### How It Works

**During execution:**
1. The agent reads SKILL.md (universal instructions)
2. The agent reads CONTEXT.md (local configuration)
3. The agent reads LEARNINGS.md in full (accumulated knowledge) and the last ~2000 characters of LOGS.md (recent history)
4. The agent executes the skill
5. After execution: append to LOGS.md (what happened) and LEARNINGS.md (what was learned, if anything noteworthy)

**The improvement cycle (human-driven):**
1. The same skill runs across one or many agents over a period of time
2. Each agent accumulates its own learnings
3. The human triggers a review: "check all learnings for skill X"
4. The agent reads LEARNINGS.md, identifies patterns, and proposes changes to SKILL.md
5. The human approves the changes
6. SKILL.md is updated, LEARNINGS.md is cleared, the updated skill is deployed
7. The cycle repeats — now from a stronger baseline

**What the agent can change — and the one rule that makes it safe:**

The agent can modify any file in the skill: SKILL.md, CONTEXT.md, LEARNINGS.md, LOGS.md, scripts, references. Nothing is off-limits. But there is one absolute rule:

**Every change must be fully documented in LEARNINGS.md.**

Each LEARNINGS.md entry for a change must include:
- **What was the problem** — what went wrong or what was missing
- **What was discovered** — the root cause or new knowledge
- **What was changed** — which files, what specifically was modified
- **What was created** — any new files, where they are located
- **Why it works better** — the reasoning behind the change

This documentation is critical because the same skill runs across multiple agents. Each agent may independently discover issues and make improvements. When the human collects learnings across agents, they need to see exactly what each agent changed and why, so they can merge the best improvements into the canonical version.

An agent that fixes a script but doesn't document it in LEARNINGS.md has made the skill better locally but created a silent fork. An agent that documents everything — even if the change itself is imperfect — gives the human what they need to build the best version.

**CONTEXT.md specifically:** The agent updates CONTEXT.md whenever execution changes local state — a new service is connected, a credential path changes, a status moves from pending to active, a new property ID is discovered. This is factual state about the local environment, and it must stay current.

### Why Separate Logs from Learnings

**LOGS.md** is factual history: what happened, when. It answers "what did this skill do last Tuesday?" Useful for debugging, not for improving the skill.

**LEARNINGS.md** is extracted wisdom: what the agent figured out. It answers "what do we know now that we didn't know before?" This is what feeds back into SKILL.md during improvement cycles.

An agent might run a skill 50 times and log all 50. But only 5 of those runs produce a genuine learning. Keeping them separate prevents noise from burying signal.

---

## Progressive Disclosure

Skills use a three-level loading system to manage context efficiently:

1. **Metadata (name + description)** — Always in context. ~100 words. This is the ONLY thing the agent sees when deciding whether to load a skill. Make it count.
2. **SKILL.md body** — Loaded when the skill triggers. Contains everything needed for standard execution.
3. **References and resources** — Loaded on demand. No size limit. The agent reads these only when it encounters a situation that needs deeper guidance.

### When to split content into references

- A section exceeds 50 lines → consider moving to `references/`
- Content only applies to one variant of the task → separate file
- Detailed API docs, schemas, or specifications → always in `references/`
- Examples and templates → `references/` or `assets/`

### Patterns

**High-level guide with on-demand references:**
```markdown
# Email Campaign Skill

## Quick Start
Draft a campaign with subject, body, and segment.

## Advanced
- **A/B testing:** See references/ab-testing.md
- **Deliverability:** See references/deliverability.md
```

**Domain-specific organization:**
```
market-research/
├── SKILL.md (workflow + method selection)
└── references/
    ├── competitor-analysis.md
    ├── voice-of-customer.md
    └── trend-research.md
```

The agent loads only the reference it needs for the current task.

---

## Core Principles

### Concise Is Key

The context window is a shared resource. The skill shares it with the system prompt, conversation history, other skills' metadata, and the user's request.

**Default assumption: the agent is already capable.** Only include knowledge the agent doesn't already have. Challenge every paragraph: "Does this justify its token cost?"

Prefer short examples over long explanations.

### Degrees of Freedom

Match specificity to the task's fragility:

- **High freedom** (guidelines, heuristics): When multiple approaches are valid and decisions depend on context. Example: "Research the topic using available search tools."
- **Medium freedom** (structured workflow with parameters): When a preferred pattern exists but variation is acceptable. Example: "Generate images at 2K resolution. Use --thinking high for complex prompts."
- **Low freedom** (exact scripts, strict sequence): When operations are fragile and consistency is critical. Example: "Run this exact API call with these exact parameters."

A narrow bridge with cliffs needs strict guardrails. An open field allows many routes.

### Explain the Why

When writing skill instructions, explain the reasoning behind rules — not just the rules themselves. The agent has good judgment. When it understands WHY a constraint exists, it can handle situations the skill author didn't anticipate.

Instead of: "ALWAYS use 2-second delays between API calls."
Write: "Use 2-second delays between API calls — the service rate-limits after rapid bursts and flags the account."

If you find yourself writing ALWAYS or NEVER in all caps, that's a signal to step back and explain the reasoning instead of enforcing rigid rules.

### Writing Patterns

**Defining output formats:**
```markdown
## Report structure
Use this template:
# [Title]
## Executive summary
## Key findings
## Recommendations
```

**Including examples:**
```markdown
## Email subject lines
Example 1:
Input: Monthly newsletter about market trends
Output: "3 market shifts you need to know this month"

Example 2:
Input: Follow-up after discovery call with prospect
Output: "Quick recap + next steps from our call"
```

Concrete examples teach more than abstract explanations.

---

## Naming Convention

Skill folders follow a prefix convention:
- **`platform-`** — External platform integrations (Discord, Slack, Shopify, FileBrowser, etc.). Setup + operations + troubleshooting in one skill. Folder: `platform-discord`, `platform-slack`. The `name:` in frontmatter is the short name without the prefix (e.g., `name: discord`), so the user types `/discord` to trigger it.
- **`system-`** — Internal system skills (domain expertise, workflows, tools). Folder: `system-market-research`, `system-invoicing`.
- **`cd-`** — Command skills (slash commands). Explicitly user-triggered. Folder: `cd-save`, `cd-checkpoint`.
- **`wf-`** — Workflow skills. Cron-triggered, no frontmatter, never auto-discovered.
- No prefix — custom or agent-specific skills that don't follow the standard categories.

## Frontmatter

```yaml
---
name: discord
description: "Use when the user asks anything about Discord."
---
```

Before writing a new skill's frontmatter, always check what skills already exist to avoid overlapping. If a similar skill exists, consider updating it instead of creating a new one.

### Writing Good Descriptions

The description has ONE job: get the skill loaded when it should be. Once loaded, SKILL.md takes over. Keep descriptions **short and keyword-anchored**.

The danger of long descriptions: if you list specific use cases ("setup, troubleshooting, channel management, permission issues"), any use case NOT listed might fail to trigger the skill. You can't predict every future use case. Instead, trigger on the **domain keyword** and let the skill's content handle routing.

**Description patterns by skill type:**

- **Platform skills** (`platform-` prefix — Discord, Shopify, Slack, FileBrowser, etc.): Very short. The platform name IS the trigger. *"Use when the user asks anything about Discord."* Any Discord question — setup, troubleshooting, channels, bots, permissions — loads the skill. Future use cases are automatically covered. For user-facing platforms like FileBrowser, trigger on what users actually say ("show me the file", "where can I edit") not just the platform name.

- **Domain skills** (market research, advertorial, invoicing): Short with a few trigger phrases, because the domain isn't always one keyword. *"Use when the user asks to research a topic, investigate a market, or deep-dive on a subject."*

- **Utility skills** (diagrams, image generation): Mention the output type. *"Use when the user needs a visual diagram, flowchart, or architecture visualization."*

- **Command skills** (save, resume, checkpoint): Mention the slash command and natural language equivalents. *"Use when the user says /save or asks to end the session, wrap up, or save everything."*

**The math:** Every description sits in `<available_skills>` for EVERY message. 50 skills × 80 words = 4000 tokens permanently consumed. 50 skills × 15 words = 750 tokens. Short descriptions save context for actual work.

**No frontmatter = no auto-discovery.** The skill still exists but only triggers when explicitly invoked. Use this for:
- Workflow skills (triggered by cron, not by users)
- Sub-skills called by other skills

---

## CREATE Mode

### Step 1: Understand the Skill

Before writing anything, answer:
- What specific tasks does this skill handle?
- What would a user say that should trigger it?
- What does the agent need to know that it doesn't already?
- What scripts, references, or assets would help?

Ask the user these questions if the answers aren't clear.

### Step 2: Initialize

Run the init script to create the standard structure:

```bash
python3 {baseDir}/scripts/init_skill.py <skill-name> --path <output-directory>
```

This creates: SKILL.md (template), CONTEXT.md, LEARNINGS.md, LOGS.md, and the optional directories.

### Step 3: Write SKILL.md

Follow this order:
1. **Frontmatter** — nail the description with specific triggers
2. **Core workflow** — the main instructions, concise, imperative
3. **References for depth** — move detailed docs out of SKILL.md
4. **Philosophy of Self-Improvement** — every skill must include this section

Every skill must include the self-improvement template below. **Copy it exactly as-is into every skill you create. Do not rewrite, adapt, or summarize it.**

```markdown
## Before Every Execution

Before doing anything, read these files in this skill's directory:
1. **CONTEXT.md** — local configuration, tools, and business-specific details
2. **LEARNINGS.md** — accumulated knowledge from past runs (read in full)
3. **LOGS.md** — recent execution history (read the last ~2000 characters only — older logs are kept for the record but don't need to be loaded every time)

These files contain knowledge that makes this run better than the last one.

## How This Skill Improves

This skill is a living system. It gets better every time it runs.

**After each execution:**
1. Append to LOGS.md: what was triggered, what actions were taken, what the outcome was
2. Update CONTEXT.md if local state changed (new credentials, new service connected, status changes, new IDs discovered)
3. If something noteworthy was learned — a new pattern, a failure, an edge case, a better approach — append to LEARNINGS.md with today's date

**If a deeper change is needed** (fixing a workflow step, updating a reference, adding a script, correcting an error in SKILL.md), you can make the change directly. But you MUST document it fully in LEARNINGS.md:
- What was the problem
- What was discovered
- What was changed (which files, what specifically)
- What was created (new files, where they are)
- Why it works better

This documentation is how the human merges improvements across agents into the canonical skill version. A change without a LEARNINGS.md entry is a silent fork.
```

### Step 4: Write CONTEXT.md

Add the agent-specific configuration:
- Which tools and APIs are available locally
- Workspace paths and credential references
- Business-specific examples and constraints
- Related skills in the local environment

### Step 5: Register the Skill

After creating a skill, add it to `SKILLS.md` at the workspace root. If SKILLS.md doesn't exist, create it (see the SKILLS.md section below for format).

Every skill must be registered — including wf-* workflows that have no frontmatter. SKILLS.md is the only way a fresh session discovers skills that aren't auto-triggered.

### Step 6: Test

Run the skill on a real task. After the first execution:
1. Did it trigger correctly from the frontmatter?
2. Were the instructions sufficient?
3. Did the agent write to LOGS.md and LEARNINGS.md?
4. Update and iterate.

### What NOT to Include in a Skill

- README.md — SKILL.md IS the documentation
- CHANGELOG.md — LEARNINGS.md tracks evolution
- INSTALLATION_GUIDE.md — not needed
- Any auxiliary documentation files — they add clutter

---

## UPDATE Mode

Update mode covers two scenarios: adding new knowledge to an existing skill, and transforming a pre-existing skill to follow the skill-forge standard.

### ⛔ The Absolute Rule: Never Lose Knowledge

When updating any existing skill, **no content is ever deleted, summarized, trimmed, or removed.** The user's skill works. It has knowledge in it. Your job is to reorganize and add — never subtract.

- Existing instructions → keep them all, reorganize into the standard structure
- Existing notes, gotchas, edge cases → keep them in SKILL.md where they belong. They are proven knowledge. LEARNINGS.md starts empty — it's for future learnings, not existing ones.
- Existing configuration → apply the extraction rule: "Would this line be different on another agent?" If yes, move it to CONTEXT.md. Credentials, channel IDs, paths, guild IDs, tool references — all CONTEXT.md. Universal instructions stay in SKILL.md.
- Existing scripts, references, assets → keep in their directories

If something looks outdated or wrong, flag it for the human. Do not remove it yourself. The worst outcome is a skill that worked before the update and doesn't work after.

### Adding new knowledge to an existing skill

1. **Gotcha or edge case** → append to LEARNINGS.md with date
2. **Core workflow change** → update SKILL.md directly + document in LEARNINGS.md (what changed and why)
3. **New reference material** → add to `references/` + document in LEARNINGS.md
4. **Script bug** → fix the script + document in LEARNINGS.md
5. **New script needed** → add to `scripts/` + document in LEARNINGS.md (what it does, why it was needed)
6. **Local state changed** → update CONTEXT.md (new services, credentials, statuses)

Every change to any file other than LOGS.md must have a corresponding LEARNINGS.md entry. This is how the human tracks what each agent has modified when merging improvements across the fleet.

Save the change. If the workspace uses git, commit and push. No need for the full creation process.

### Transforming an existing skill to the standard

When a user has a working skill that doesn't follow the skill-forge structure and wants to upgrade it:

1. **Read the entire existing skill first.** Understand every piece of knowledge in it.
2. **Create the missing files:** CONTEXT.md, LEARNINGS.md, LOGS.md — without touching the existing SKILL.md yet.
3. **Extract agent-specific content** from SKILL.md into CONTEXT.md. Apply the extraction rule: "Would this line be different on another agent?" If yes, it goes in CONTEXT.md. Credentials, channel IDs, paths, guild IDs, tool references — all CONTEXT.md. Universal instructions stay in SKILL.md.
4. **Leave existing knowledge in SKILL.md.** Gotchas, edge cases, and learnings that are already in the skill belong there — they are proven. LEARNINGS.md starts empty and will accumulate new knowledge from future executions.
5. **Add the self-improvement template** to the end of SKILL.md (the static block from CREATE mode).
6. **Verify nothing was lost.** Every piece of information from the original skill must exist somewhere in the new structure — either in SKILL.md, CONTEXT.md, LEARNINGS.md, or `references/`.
7. **Test the skill** to confirm it still works exactly as before.

---

## DEPRECATE Mode

When a skill is replaced, merged into another skill, or no longer needed:

1. **Move the entire skill folder** to `archives/skills/`. If `archives/skills/` doesn't exist, create it.
2. **Log the archival** in `archives/DONE-LOG.md`. If DONE-LOG.md doesn't exist, create it. Format: `YYYY-MM-DD | skill-name | reason (e.g., "merged into platform-discord")`
3. **Remove from SKILLS.md** at workspace root (if it exists there).
4. **Clean up references** — grep the workspace for the old skill name and update any references to point to the replacement.

---

## SKILLS.md — The Skill Registry

Every agent must have a `SKILLS.md` file at the workspace root. This is the complete inventory of all skills available to the agent.

**Format:**
```markdown
# SKILLS.md — Skill Registry

| Skill | Description |
|-------|-------------|
| skill-forge | Create or update skills |
| cd-save | End-of-session save |
| wf-morning-brief | Daily morning briefing |
| ... | ... |
```

**Rules:**
- After creating a new skill → add it to SKILLS.md
- After renaming a skill → update the entry in SKILLS.md
- After archiving a skill → remove it from SKILLS.md
- If SKILLS.md doesn't exist when you need to register a skill → create it and list all skills in the `skills/` directory

SKILLS.md is how a fresh session knows what skills are available beyond the auto-discovered ones in `<available_skills>`. Workflow skills (wf-*) and sub-skills without frontmatter are only discoverable through SKILLS.md.

---

*The skill-forge follows its own standard. Read CONTEXT.md, LEARNINGS.md, and LOGS.md before every execution. Write to LOGS.md and LEARNINGS.md after. Any changes to SKILL.md must be documented in LEARNINGS.md.*

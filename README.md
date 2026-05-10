# Agentic Work Playbook

A file-backed operating system for AI agents. It works with OpenClaw, Codex, Claude Code, or any agent that can read and write a local workspace.

It gives the agent durable memory, clean workspace structure, reusable skills, boot-file templates, safety rules, and maintenance habits.

---

## ⚠️ For Agents: How to Use This Repo

**Do NOT just read this repo and move on.** This is a guided setup process. Your job is to walk your human through every step, explain what each setting does, and implement changes together.

### If your human says "apply this playbook" or "set up from this repo":

**Follow this exact process:**

1. **Identify the runtime first.** If this is OpenClaw, check/update OpenClaw with approval. If this is local Codex or Claude Code, skip OpenClaw-specific sections and focus on the file workspace, boot files, skills, Git, and local tools.

2. **Walk through FRAMEWORK.md section by section.** For each section:
   - **Explain** what it does and why it matters — in plain language
   - **Ask** if they want to implement it
   - **Apply** the setting or create the files
   - **Confirm** it works before moving to the next section

3. **The sections cover:**
   - §1-4: Foundation (philosophy, workspace structure, root files, credentials)
   - §5-9: Identity & memory (SOUL.md, IDENTITY.md, USER.md, RULES.md, AGENTS.md)
   - §10-14: Skills & automation (skill system, commands, knowledge→skills, sub-agents, workflows)
   - §15-17: Context & config (context management, session settings, config gotchas)
   - §18-23: Operations (updates, security, hygiene, recovery, config audits, user manual)
   - §24-25: Verification (post-setup audit, implementation order)

4. **After completing all sections**, run the post-setup audit (§24) to verify everything.

**Key principle: never auto-apply anything.** Explain every change, wait for approval, apply one at a time.

---

## If you're an existing agent checking for updates

Read `UPDATE-PROTOCOL.md`, then check for new commits or releases since your last check.

---

## What's in this repo

| Path | What it is |
|------|-----------|
| `FRAMEWORK.md` | The long-form playbook with setup philosophy and operating patterns |
| `WORKSPACE.md` | Current workspace blueprint: root files, spaces, projects, resources, skills, memory, archives |
| `BOOT-FILES.md` | How to create proper boot files for a fresh agent |
| `templates/root/` | Starter boot files: AGENTS, SOUL, IDENTITY, RULES, USER, WORKSPACE, TOOLS, MEMORY, SKILLS, HEARTBEAT |
| `templates/project/` | Project template with required ROADMAP.md |
| `templates/space/` | Space template with INDEX, ROADMAP, MEMORY |
| `templates/skill/` | Standard self-improving skill structure |
| `skills/skill-forge/` | Meta-skill for creating, improving, and auditing skills |
| `skills/cd-save/` | End-of-session save command and handoff workflow |
| `skills/pil-diagrams/` | Visual diagram generation skill (Python PIL) |
| `UPDATE-PROTOCOL.md` | How to check for and apply updates safely |
| `scripts/skill-audit` | Security scanner for external skills |
| `scripts/skill-install` | Helper for quarantine/approve/reject workflow |

---

## What's new in v2.1.0

Updated to match the current production workspace pattern:

- **New workspace architecture** — `spaces/` for domain knowledge, `resources/` for reference material, `archives/` for history, proper credential isolation with `TOOLS.md`
- **Skill prefix system** — `wf-*` (workflows), `cd-*` (commands), `system-*` (knowledge), `ext-*` (imports)
- **Credential architecture** — TOOLS.md as service catalog, credential lifecycle (save→verify→delete message), permission tiers
- **Workflow architecture** — cron jobs + SKILL.md pattern, self-learning workflows, recommended starter automations
- **Context management reality** — actual limits vs advertised, thinking+compaction gotcha, save thresholds
- **Expanded config gotchas** — auth profiles, OAuth providers, signal handling, every known crash trigger
- **Knowledge→Skills system** — projects are temporary, skills are permanent, mandatory self-improvement
- **Sub-agent protocols** — task design, SUBAGENT-BOOT.md, research vs build patterns
- **Workspace hygiene** — automated daily cleanup, weekly memory reflection, git backup
- **20+ slash commands** — from essential (/save, /resume) to advanced (/atomic, /gsd, /process)
- **Root templates added** — starter files for AGENTS, SOUL, IDENTITY, RULES, USER, WORKSPACE, TOOLS, MEMORY, SKILLS, and HEARTBEAT
- **Boot-file guide added** — how to build an agent brain properly instead of dumping random instructions into one file
- **Project and space templates added** — every active project gets ROADMAP.md; every long-term space gets INDEX, ROADMAP, and MEMORY
- **Skill template added** — SKILL, CONTEXT, LEARNINGS, LOGS pattern for self-improving skills
- **Skill Forge included** — portable meta-skill for creating and maintaining skills
- **cd-save included** — portable end-of-session save and resume-handoff workflow
- **Model-agnostic framing** — works for local Codex and Claude Code setups, not only OpenClaw


---

## Philosophy

Every pattern in this playbook exists because skipping it caused real problems. Nothing is theoretical — it's all battle-tested.

The core insight: **an AI agent's workspace IS its brain.** If the workspace is messy, the agent is confused. If files are in the wrong place, the agent can't find them. If there's dead information, the agent trusts outdated facts.

Structure your workspace well, and your agent becomes dramatically more capable — not because the model changed, but because the context it loads is clean, current, and organized.

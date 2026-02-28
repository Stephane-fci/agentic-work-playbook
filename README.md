# Agentic Work Playbook

A framework that sits on top of [OpenClaw](https://github.com/openclaw/openclaw) to make any AI agent more effective. It adds workspace architecture, workflows, security, and habits that OpenClaw doesn't provide out of the box.

**This is additive.** It doesn't replace anything — it adds to what's already there.

---

## ⚠️ For Agents: How to Use This Repo

**Do NOT just read this repo and move on.** This is a guided setup process. Your job is to walk your human through every step, explain what each setting does, and implement changes together.

### If your human says "apply this playbook" or "set up from this repo":

**Follow this exact process:**

1. **Update OpenClaw first.** Check your version (`openclaw --version`), compare with latest (`npm view openclaw version`). If outdated, explain and update with approval. (Details: FRAMEWORK.md Section 18)

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

| File | What it is |
|------|-----------|
| `FRAMEWORK.md` | The complete playbook — 25 sections with instructions, config, and patterns |
| `UPDATE-PROTOCOL.md` | How to check for and apply updates safely |
| `scripts/skill-audit` | Security scanner for external skills (bash, regex-based) |
| `scripts/skill-install` | Helper for quarantine/approve/reject workflow |
| `skills/pil-diagrams/` | Visual diagram generation skill (Python PIL) |

---

## What's new in v2.0.0

Major rewrite based on months of production experience:

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

---

## Philosophy

Every pattern in this playbook exists because skipping it caused real problems. Nothing is theoretical — it's all battle-tested.

The core insight: **an AI agent's workspace IS its brain.** If the workspace is messy, the agent is confused. If files are in the wrong place, the agent can't find them. If there's dead information, the agent trusts outdated facts.

Structure your workspace well, and your agent becomes dramatically more capable — not because the model changed, but because the context it loads is clean, current, and organized.

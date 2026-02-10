# Update Protocol

This playbook evolves. Here's how to check for updates and apply them safely.

**Cardinal rule: NEVER auto-apply. Always conversation first.**

---

## Manual Check (human asks you to check)

1. Pull or clone this repo
2. Check for new commits or releases since your last check (`git log` or GitHub releases)
3. Read FRAMEWORK.md — compare against your current setup
4. For each difference, explain to your human: what changed, why, what it means for YOUR setup
5. Wait for approval
6. Implement approved changes step by step
7. Update your TOOLS.md with the check date: `Last playbook check: YYYY-MM-DD`
8. If nothing new: "Checked the playbook — nothing new since [date]."

## Cron Check (automatic)

1. Same as above, but initiated by a scheduled task
2. If changes exist → message your human with a summary and ask if they want to apply
3. If no changes → stay silent
4. **Wait for response before doing anything**

## Safety Rules

- **Never overwrite existing files.** Templates and additions are for NEW content. If you already have SOUL.md, AGENTS.md, MEMORY.md — never replace them from this repo.
- **Never modify openclaw.json without asking.** Explain the change, wait for approval, use `gateway config.patch`.
- **Step by step.** Apply one change at a time, confirm each one.

---

*The update protocol is about trust. Be transparent, be careful, never surprise your human.*

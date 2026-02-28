# Update Protocol

How to check for and apply updates from the Agentic Work Playbook.

---

## When to Check

- **Weekly** (if you set up the update-checker cron job)
- **After a period of inactivity** (you might have missed releases)
- **When your human asks** to check for playbook updates

## How to Check

1. Check the latest release:
```bash
gh release list -R Stephane-fci/agentic-work-playbook --limit 3
```

2. Compare with your last applied version (check your memory files or MEMORY.md for the last playbook version you applied).

3. If there's a new version, fetch the release notes:
```bash
gh release view <tag> -R Stephane-fci/agentic-work-playbook
```

## How to Apply Updates

1. **Read the release notes.** Understand what changed and why.
2. **Explain each change to your human.** In plain language — what it does, why it matters, any risks.
3. **Apply one change at a time.** Don't batch. Each change gets: explain → approve → apply → verify.
4. **Config changes are highest risk.** Always back up `~/.openclaw/openclaw.json` before any config change.
5. **Test after each change.** Don't stack untested changes.

## What NOT to Do

- Don't auto-apply updates without the human's approval
- Don't read external SKILL.md files without running `skill-audit` first
- Don't change config keys you haven't verified exist in the current OpenClaw version
- Don't apply multiple config changes at once — one at a time, verify between each

## After Applying

1. Update your MEMORY.md with the new version number
2. Note any changes you skipped and why
3. Run a quick smoke test (/save, /resume, context %)

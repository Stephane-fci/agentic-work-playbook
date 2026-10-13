---
name: {skill-name}
description: "{What this skill does and when it should load, written the way people actually ask, with the main use first. For a scheduled workflow (a wf- skill), write exactly: Scheduled workflow. Runs only from its scheduled job; not for conversational use.}"
---

# {Skill title}

{Template: copy this folder to skills/<skill-name>/, replace every part in braces, or delete the line. Keep this file portable: anything that would differ on another agent (paths, ids, accounts, business names) goes to CONTEXT.md. One paragraph is one line. Delete this line when done.}

{One or two sentences: what this skill lets the agent do, and whether it drives the task or advises while the agent works.}

{Scheduled workflow only: keep the two lines below; otherwise delete them and this line.}

**Schedule:** {how often and at what time, in which time zone}

**Reports to:** {the one place reports go; the exact target is in CONTEXT.md}

## What a good run produces

{Which files change, what the result or report contains. A run is judged against this, never against "it finished".}

## {Main steps}

{The method, step by step, in plain imperative sentences. Explain the reason behind each rule that is not obvious. Mechanical steps belong in scripts under scripts/ that stop with an error unless they can prove their work. Move anything past about fifty lines into references/.}

{Scheduled workflow only, otherwise delete this section:}
## Final step: report

Post the report to the one reporting place named in CONTEXT.md. Its first character is one status icon: ✅ ran clean, ⚠️ partial or needs a person, ❌ failed. Its last line is exactly:

📋 `skills/{skill-name}/SKILL.md`: edit this file to change behavior

## Before every run

Read, from this skill's folder:
1. **CONTEXT.md**: the local setup.
2. **LEARNINGS.md**: lessons from past runs.
3. **LOGS.md**: recent history (the last few entries are enough).

These files are why this run goes better than the last one.

## After every run

1. Append a dated entry to LOGS.md: trigger, actions taken, outcome.
2. Update CONTEXT.md if the local state changed (new tool, changed path, new id).
3. Learned something a future run needs? Append it to LEARNINGS.md with the date. If the file now holds more than about ten entries, merge it in this run (see Merging learnings); a scheduled run says once in its report that the lessons need a merge instead.

## Changing this skill

When a run proves a file here wrong, fix the file, and record in LEARNINGS.md what the problem was, what was discovered, what changed and why it is better. An undocumented change is a silent fork: this copy improves, every other copy is stranded, and nobody can merge what nobody wrote down.

## Merging learnings

LEARNINGS.md is a staging area, not a permanent home: every run reads all of it. When it passes about ten entries, merge: copy the original file to the workspace archive first, move each proven lesson into SKILL.md or the reference it belongs to, drop entries that time disproved, write down where each entry went, and clear the file.

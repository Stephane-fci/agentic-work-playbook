#!/usr/bin/env python3
"""
Skill Initializer — Creates a new skill following the skill-forge standard.

Usage:
    init_skill.py <skill-name> --path <path>

Examples:
    init_skill.py market-research --path ~/agent-workspace/skills
    init_skill.py email-triage --path /home/agent/skills
"""

import sys
from pathlib import Path


SKILL_TEMPLATE = '''---
name: {skill_name}
description: "[TODO: What this skill does AND when to use it. Include specific trigger phrases and task types. Be comprehensive — even pushy — about when to trigger. This is the ONLY thing the agent sees before deciding to load the skill.]"
---

# {skill_title}

[TODO: 1-2 sentences explaining what this skill enables.]

## [Main Section]

[TODO: Core workflow or instructions. Use imperative form. Move detailed reference material to references/.]

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
'''

CONTEXT_TEMPLATE = '''# Context

[TODO: Add agent-specific configuration here]
## Tools & APIs
[TODO: Which specific tools and APIs are available locally]

## Workspace
[TODO: Workspace paths, credential references]

## Business-Specific
[TODO: Business-specific examples, edge cases, constraints]
'''

LEARNINGS_TEMPLATE = '''# Learnings
Learnings are written here by the agent after each execution.
The human periodically reviews, merges the best into SKILL.md, and clears this file.
'''

LOGS_TEMPLATE = '''# Logs
Execution history is appended here after each run.
'''


def title_case(name):
    return ' '.join(w.capitalize() for w in name.split('-'))


def init_skill(skill_name, path):
    skill_dir = Path(path).resolve() / skill_name

    if skill_dir.exists():
        print(f"❌ Skill directory already exists: {skill_dir}")
        return None

    try:
        skill_dir.mkdir(parents=True)
    except Exception as e:
        print(f"❌ Error creating directory: {e}")
        return None

    # Core files
    (skill_dir / "SKILL.md").write_text(
        SKILL_TEMPLATE.format(skill_name=skill_name, skill_title=title_case(skill_name))
    )
    (skill_dir / "CONTEXT.md").write_text(CONTEXT_TEMPLATE)
    (skill_dir / "LEARNINGS.md").write_text(LEARNINGS_TEMPLATE)
    (skill_dir / "LOGS.md").write_text(LOGS_TEMPLATE)
    print("✅ SKILL.md, CONTEXT.md, LEARNINGS.md, LOGS.md")

    # Optional directories
    for d in ["scripts", "references", "assets"]:
        (skill_dir / d).mkdir(exist_ok=True)
    print("✅ scripts/ references/ assets/")

    print(f"\n✅ Skill '{skill_name}' initialized at {skill_dir}")
    print("\nNext steps:")
    print("1. Edit SKILL.md — fill the description and core workflow")
    print("2. Edit CONTEXT.md — add local tools, paths, business details")
    print("3. Delete unused directories (scripts/, references/, assets/)")
    print("4. Register the skill in SKILLS.md at workspace root")
    return skill_dir


def main():
    if len(sys.argv) < 4 or sys.argv[2] != '--path':
        print("Usage: init_skill.py <skill-name> --path <path>")
        sys.exit(1)

    result = init_skill(sys.argv[1], sys.argv[3])
    sys.exit(0 if result else 1)


if __name__ == "__main__":
    main()

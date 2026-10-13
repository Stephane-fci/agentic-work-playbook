# CLAUDE.md: Claude Code in this workspace

{Template: keep one import line per Markdown file at the top of the workspace, written as a plain line, never inside backticks. Add a line whenever a root file is added. With Agent Bridges each file is still read once; without it, these lines are how a Claude Code session loads the boot files. Beside another agent: remove the lines for that agent's SOUL.md, IDENTITY.md and AGENTS.md, and write the full engine connection below instead. Delete this line when done.}

@WORKSPACE.md

@OPERATING-MODE.md

@COMMUNICATION.md

@SOUL.md

@IDENTITY.md

@USER.md

@RULES.md

@TOOLS.md

@MEMORY.md

@SKILLS.md

@AGENTS.md

## On Claude Code

AGENTS.md says how you work on your engine. This file adds only what is specific to Claude Code.

In a session started without the bridge, read today's and yesterday's daily memory files in `memory/` before your first answer, if they exist. A boot file edited during such a session applies from the next session, or after `/clear`.

{Other notes that apply only on Claude Code, such as how to use subagents or an output style. Delete this line when there are none.}

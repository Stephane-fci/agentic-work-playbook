# TOOLS.md: what {agent name} can reach

{Template: replace every part in braces, or delete the line. Delete this line when done.}

Every tool gets four things: what it does, where its credential is kept (the place, never the value), which skill to read first, and when it was last checked. A tool counts as connected only after a real read-only check. If a skill is named, read it before the first call.

## The machine

{Where the agent runs (server or computer), its workspace folder, its rights on the machine, and the protected folder outside the workspace where secrets are kept.}

## Connected and proven

| Tool | What it does | Credential kept in | Skill to read first | Last checked |
|---|---|---|---|---|
| {tool} | {what it does for {person}} | {path or variable name, never the value} | {skill name, or none} | {YYYY-MM-DD} |

## Planned, not connected

| Tool | Why it is wanted | State |
|---|---|---|
| {tool} | {purpose} | {not connected, waiting on what} |

## Not allowed

{Tools, accounts or keys the agent must not use, and why. For example another client's key.}

## Adding a tool

{The steps for a new tool. For example: read the official documentation; ask for the smallest access that does the job; {person} enters the secret in the agreed safe way; test read-only first; record it here with the date; propose any write only after that.}

Pitfalls of a tool live in its skill. A tool without a skill keeps at most one warning line here.

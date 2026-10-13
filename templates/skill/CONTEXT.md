# Context: {skill-name}

{Template: the local half of the skill. The skill reads this before every run. Paths, names and places only, never secret values. Delete this line when done.}

## Workspace

{The paths this skill needs on this machine.}

## Tools

{The tools and services it uses, and where each credential is kept: a path or a variable name, never the value.}

## Specifics

{Business rules, examples, ids and related skills on this machine.}

## Reporting

{Scheduled workflow only, otherwise delete this section.}

- Place: {the exact channel or file where reports go}
- Schedule: {cron line or repeat, and the time zone}
- Schedule entry name: {skill-name}
- Scheduler: {Agent Bridges job, or the server's scheduler}

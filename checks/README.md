# Workspace check

`check-workspace.sh` is a small read-only script that checks a workspace's structure against this guide. The agent runs it at the end of setup and after every update, as step 1 of [docs/verify.md](../docs/verify.md).

## How to run it

From the guide's folder: `bash checks/check-workspace.sh /path/to/workspace`

From inside the workspace: `bash /path/to/guide/checks/check-workspace.sh`

It needs only bash (version 3.2 or newer) and standard tools that every Linux server and Mac already has: find, grep, awk, sed and wc. There is nothing to install.

## What it checks

- Boot files: every required boot file is present and not empty (WORKSPACE.md, OPERATING-MODE.md, COMMUNICATION.md, SOUL.md, IDENTITY.md, USER.md, RULES.md, TOOLS.md, MEMORY.md, SKILLS.md), with at least one engine file (CLAUDE.md or AGENTS.md). Extra boot files are listed, and a file too big for Agent Bridges to deliver is flagged. The specification is in [docs/boot-files.md](../docs/boot-files.md).
- The top of the workspace: boot files only, named in capitals. Any other file there must move; an unknown folder is flagged.
- Folders: `spaces/`, `projects/`, `resources/`, `skills/`, `memory/` and `archives/` exist. `repositories/` and `dashboards/` are optional.
- Inside the folders: each space has INDEX.md, each project has README.md, STATE.md and LOGS.md, each resources folder has INDEX.md, `repositories/INDEX.md` names every repository, each dashboard has a README.md, each skill has a SKILL.md with a name and a description (only a warning for a scheduled `wf-` skill) and is listed in SKILLS.md, `memory/` holds daily files named by date, and `archives/` has its DONE-LOG.md. The layout is in [docs/workspace.md](../docs/workspace.md).
- Secrets: no secret value in any Markdown file. Private keys and known key formats must be fixed. A long value after a word such as "token" or "password" is a warning to look at, because it may be harmless.
- Records: the installed receipt `.playbook/installed.json` and its version ([docs/update.md](../docs/update.md)), and whether the workspace is a Git repository with a remote copy for backups.

Folders whose names start with `_` are skipped as templates.

## Reading the result

Each line starts with a label:

- PASS: the check holds.
- FIX: the guide requires it, and it is missing or wrong. The line says what to do and which page to read.
- WARN: it does not block, but it points to a real gap or to something to look at.
- NOTE: information only.

At the end, the script prints the counts and the result. Exit code 0 means every required check passes, warnings allowed. Exit code 1 means at least one line says FIX. Exit code 2 means the folder could not be opened.

## What it never does

It never creates, changes or deletes a file. It never uses the network and never runs Git, because even a Git status can rewrite Git's own files. It never prints a secret value: for a secret-looking value, it shows only the file and the line number.

## What it does not prove

It checks the structure, not the behaviour. Whether the agent really receives its boot files, follows its rules and resumes work from the files is proven by the rest of [docs/verify.md](../docs/verify.md).

# Update the guide in a workspace

This page explains how a workspace moves to a new version of the guide without losing anything personal, and how to go back when something breaks.

## One version source

The guide's version is the single line in [VERSION](../VERSION), for example `3.0.0`. [CHANGELOG.md](../CHANGELOG.md) says what changed in each version and why. Nothing else carries the version: not the README, not a release page, not MEMORY.md.

The three numbers say how much care an update needs. The last number changes for corrections, such as 3.0.1. The middle number changes when something is added, such as 3.1.0. The first number changes when the method itself changes and the workspace needs real work, such as 4.0.0.

The guide's version is separate from the versions of Agent Bridges and of the engines. Each one has its own update path: the bridge's own update guide for the bridge and the engines it runs, and the engine's own installer otherwise. Updating the guide never updates the bridge or an engine, and updating them never changes the guide's files in the workspace. After any of them changes, run [verify.md](verify.md).

## The installed receipt

The workspace keeps one record of what the guide installed: `.playbook/installed.json`. It sits in a hidden folder at the top of the workspace, so it is never read as a boot file. The agent writes it at the last step of [START-HERE.md](../START-HERE.md), rewrites it after each update, and commits it with the workspace.

It holds the guide version, the dates, and every file the guide installed, each with its class and its hash. A hash is a short fingerprint of a file's content: change one character and the fingerprint changes. Get it with `sha256sum FILE` on Linux or `shasum -a 256 FILE` on a Mac. The recorded hash is always the fingerprint of the guide's own file at the installed version (its `source`).

A fictional example, with the hashes shortened:

```json
{
  "guide": "agentic-work-playbook",
  "version": "3.0.0",
  "installed": "2026-10-20",
  "updated": "2026-10-20",
  "files": [
    { "path": "WORKSPACE.md", "source": "templates/root/WORKSPACE.md", "class": "shared", "sha256": "9f2c07..." },
    { "path": "OPERATING-MODE.md", "source": "templates/root/OPERATING-MODE.md", "class": "shared", "sha256": "e1a4b2..." },
    { "path": "COMMUNICATION.md", "source": "templates/root/COMMUNICATION.md", "class": "shared", "sha256": "41d7c9..." },
    { "path": "USER.md", "source": "templates/root/USER.md", "class": "personal", "sha256": "c08e5f..." },
    { "path": "SKILLS.md", "source": "templates/root/SKILLS.md", "class": "generated", "sha256": "77ab30..." }
  ]
}
```

A file may also carry a `note`. When the person refuses a proposed change to a shared file, the agent writes the version, the date and the reason there, for example `"note": "3.1.0 change to the update rule refused on 2026-11-02: keeps its own shorter rule"`. The next update then does not ask again about the same change, and the exception stays visible instead of being kept in silence.

## Three kinds of file

Every file the guide installs belongs to one class, written `shared`, `personal` or `generated` in the receipt. The class decides what an update may do with the file.

- Shared method files: WORKSPACE.md, OPERATING-MODE.md and COMMUNICATION.md, copied whole from the guide. When the local copy still matches its recorded hash, nobody edited it, and the update replaces it. When someone edited it, the update never overwrites it: it shows the guide's change next to the local edit and proposes one merged text for the person to accept or refuse.
- Personal files: everything written for this agent and this person, such as SOUL.md, IDENTITY.md, USER.md, RULES.md, TOOLS.md, AGENTS.md, CLAUDE.md, any profile file, and all spaces, projects, skills and memory. The update never overwrites them. When a new version asks for something new in one of them, such as a new section, the agent proposes the addition and fills it from what the workspace already shows, marking unknown facts as unknown.
- Generated files: files rebuilt from the workspace itself, such as SKILLS.md (rebuilt from the skills folder) and MEMORY.md (rebuilt every night by the nightly harvest, see [upkeep.md](upkeep.md)). The update never copies them from the guide. When a new version changes their format, the agent rebuilds them with the new rule.

A file that is not in the receipt is personal.

## Update steps

Work through the steps in order. Show the person the plan before step 4.

1. Read. Get the new version of the guide, for example with `git pull` in your copy of the guide. Read CHANGELOG.md from the installed version, which the receipt gives, up to the new one. Note every change that needs the person's decision.
2. Compare. For each file in the receipt, and each file the new version adds or retires, decide what happens: an untouched shared file is replaced, an edited shared file gets a proposed merge, a personal file stays as it is (with a proposed addition when its template asks for something new), and a generated file is rebuilt. To see whether a template changed, compare the new template's hash with the recorded one.
3. Stage. Commit any unsaved work in the files the update touches, and leave other people's and other agents' work alone. Write down the current commit with `git rev-parse HEAD`: that is the way back. Prepare the new content, then tell the person in plain words what will be replaced, what needs their decision and what stays.
4. Apply. Replace the untouched shared files, apply the merges the person accepted, add the accepted sections to personal files and rebuild the generated files. Running the update twice must give the same result: never add a second copy of an import line, a link or a scheduled job.
5. Verify. Run [verify.md](verify.md): at least the structure check, the loading check and questions 1 and 6, plus every question the changes touch.
6. Record. Rewrite `.playbook/installed.json` with the new version, the date and the new hash of every file. Commit only the files the update touched, with a message that names the version, such as "Playbook update to 3.1.0". Then tell the person what changed for them.

What to tell your person: "Your guide moved from version 3.0.0 to 3.1.0. I replaced two shared rule files you never edited, kept your own files as they were, and every check still passes. One choice is yours: the new rule about weekly reports. Do you want it?"

## The way back

Every update can be undone with Git. The commit you wrote down in step 3 is the last state before the update.

- To undo an update that was already committed, revert its commit: `git revert <update-commit>`. History keeps both the update and its undoing.
- To undo before anything was committed, restore only the files the update touched, for example `git restore --source <noted-commit> -- WORKSPACE.md COMMUNICATION.md`.
- Never reset the whole workspace (`git reset --hard`) to undo an update: it also throws away other work in progress.

When a check fails halfway, stop. Leave the receipt at the old version. Write what was applied and what was not in the setup project's STATE.md, or in today's daily memory file when there is no project. Then either fix the cause and finish, or take the way back. A half-applied update is fine as long as it is written down; a silent one is not.

## When to look for a new version

Look when the person asks, or on a schedule if they choose: a monthly upkeep job can compare the receipt's version with the guide's VERSION and report one line when a newer version exists. There is no always-running update service, and no update is applied without the person seeing the plan first.

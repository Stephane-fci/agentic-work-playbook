# Verify the setup

Run this check at the end of setup and after every update. It shows what really works, with proof, instead of what the agent believes works. It takes about half an hour. The agent does the work; the person answers a few questions in a chat and reads the result.

Go in order. When a step fails, fix the cause and run that step again before you go on.

## Before you start: write down the setup

Put these facts at the top of the report, so anyone can repeat the check:

- The workspace folder.
- The engine (Claude Code or Codex) and its version.
- Whether Agent Bridges delivers the boot files, and its version. With the bridge, its doctor lists the files it delivers ([adapters/agent-bridges.md](../adapters/agent-bridges.md)).
- The boot files you expect the agent to receive, and every file left out on purpose, with the reason. For example, another agent's identity files in a shared workspace, or the other engine's own instruction file.
- The guide version, from [VERSION](../VERSION).

## Step 1: the structure check

Run the read-only script from the guide's folder: `bash checks/check-workspace.sh /path/to/workspace`. Details are in [checks/README.md](../checks/README.md). The step passes when the script ends with exit code 0, which means no line says FIX. Read every WARN line too: a warning does not block, but each one points to something real. The script proves the structure only, not the agent's behaviour.

## Step 2: the loading check

This proves the agent receives every boot file in full, fresh at every turn. The idea: put two secret check lines in each boot file, one in the middle and one at the end, then ask the agent to quote them all without opening any file. A file cut short usually loses its middle or its end, so both lines arriving shows the whole file arrived.

1. Make sure the boot files have no unsaved changes in Git (`git status`). The check is undone at the end by putting them back exactly as they are now.
2. At the top of the workspace, add the check lines without showing the codes:

```bash
for f in *.md; do
  m=$(( $(wc -l < "$f") / 2 + 1 ))
  awk -v m="$m" -v f="$f" -v c="$(od -An -N4 -tu4 /dev/urandom | tr -d ' ')" 'NR==m{print "Check line " f " middle: " c} {print}' "$f" > "$f.check" && mv "$f.check" "$f"
  printf '\nCheck line %s end: %s\n' "$f" "$(od -An -N4 -tu4 /dev/urandom | tr -d ' ')" >> "$f"
done
```

   The command prints nothing, so the codes exist only in the files. That is what makes the test fair, even when the agent itself runs it.
3. Start a fresh turn. With Agent Bridges, simply send the next message. Without the bridge, start a new session first, because the engine reads the files only when a session starts ([adapters/claude-code.md](../adapters/claude-code.md), [adapters/codex.md](../adapters/codex.md)).
4. Ask: "Without opening any file, quote both check lines of every boot file you received, with the file name." Watch the turn. If the agent opens or searches a file, the codes are spoiled: put the files back (`git checkout -- *.md`), add new codes with step 2, and ask again in a new turn.
5. Compare the answer with the real lines, which `grep -h "^Check line" *.md` prints. The step passes when every expected file is quoted with both exact codes, no code is invented, and no file left out on purpose appears.
6. Look at the sending side too. With Agent Bridges, its doctor must list every boot file and report none left out ([adapters/agent-bridges.md](../adapters/agent-bridges.md)). On Codex with the hook, the hook's output must hold each file whole ([adapters/codex.md](../adapters/codex.md)). The codes prove what the agent received; this proves nothing was cut on the way.
7. Prove the files are fresh. Add a new end line to one file only, with the `printf` line of step 2 limited to that file, for example `USER.md`. In the same conversation, ask again for that file's last check line. With Agent Bridges, the new code must appear at the next message. Without the bridge, in an interactive session the old code is expected until a new session starts: write that down as a known limit of the setup. A print call (`claude -p`, even with `--resume`) is a new process that loads the files again, so it shows the new code at once; that is normal, not a failure.
8. Put the boot files back: `git checkout -- *.md`. Then `git diff` on the boot files must show nothing.

What to tell your person: "I put secret codes in the middle and at the end of each of my instruction files and asked myself to quote them without looking. Every code came back, so I really receive all my instructions, fresh at every message."

## Step 3: the six questions

Each question has one test and one clear pass. Run the tests in a fresh conversation unless the test says otherwise. Use real but harmless material: read only, nothing sent, nothing deleted.

### 1. Does it know its role, its person and its limits?

Ask: "Who are you, who do you work for, and what will you never do without asking first?" It passes when the agent gives its own name and role from its identity files, the person from USER.md, and its real boundaries in its own words, such as no spending, sending, publishing or deleting without authorization. In a workspace shared with another agent, it must not take that agent's name or personality.

### 2. Does it receive the intended boot files?

This is the loading check of step 2. It passes when every expected file was quoted with its exact code, every file left out on purpose stayed out, and the report gives the reason for each file left out.

### 3. Can it find a skill and read through a real tool?

Give a small read-only task that one of its skills covers and that needs a connected tool. For example: "What are the three newest orders in the shop?" or "Which meetings do I have tomorrow?" It passes when the agent names the skill it used, the tool call shows in the turn, and the answer matches what the person sees in the tool itself. When no tool is connected yet, write "not checked: no tool connected" instead of passing it.

### 4. Does it place work correctly and resume from the files?

In one conversation, give the agent one lasting fact and one bounded piece of work. For example: "Our return window is 30 days" and "Let's plan the spring sale; we choose the discount next week." Then make one decision together, such as "We go with 15 percent." It passes when the fact lands in its lasting home (a space, or USER.md when it is about the person), the work becomes a project with README.md, STATE.md and LOGS.md, and the decision is written in that STATE.md.

Then open a brand-new conversation and ask: "Where are we on the spring sale?" It passes when the answer comes from STATE.md, decision included, without anyone repeating it. When the test material is not real work, archive or remove it with the person's agreement.

### 5. Can it read the channel emojis? (only when Discord is used)

Take three channel names built from the emoji legend in RULES.md, one of them with an end mark, and one thread name that contains an emoji as a picture. Ask what each one is about and which project or space owns it. It passes when the agent reads the bucket from the first emoji of each channel name, reads the end mark as a status, treats the emoji in the thread name as a picture and not as a bucket, and names the owning files. The method is in [discord.md](discord.md). Without Discord, write "not used".

### 6. Can setup and an update be repeated safely?

This question only compares: it never starts the setup, an update or this check again, so it cannot run in circles. Go through steps 5 to 7 of [START-HERE.md](../START-HERE.md) a second time and list what each would change, without applying it. It passes when the list is empty, or holds only what is truly missing, with no second copy of an import line, a link or a scheduled job.

Then do the comparison part of [update.md](update.md) against the receipt, for the version already installed, without applying anything. It must find nothing to replace and leave every personal file alone. Finally, try the way back that update.md describes on a harmless test commit. It passes when Git shows no change to any personal file and the way back restores the previous state exactly.

## Upkeep and backup, when installed

For each upkeep job that is installed, show one real run: its report in the place where reports go, and who owns its schedule. A scheduler that says "ran" proves only that something started. For the backup, fetch one harmless file from the backup copy, such as yesterday's daily memory file, and compare it with the workspace. When a job is not installed, say so plainly in the report. The jobs are listed in [upkeep.md](upkeep.md).

## What counts as proof

Proof is something the person could check again:

- the codes quoted back in a turn where no file was opened;
- a tool call visible in the turn, with an answer that matches the source;
- a change on disk, shown by Git;
- a fresh conversation that resumes from STATE.md;
- the actual report of a scheduled job;
- a file fetched back from the backup.

These do not count:

- the agent saying it read everything, or that it will follow a rule;
- a description of what the agent would do;
- a scheduler status without the job's output;
- a "fresh conversation" test run inside the conversation that just wrote the files;
- the structure check passing, which proves the folders, not the behaviour.

No finite check guarantees that an agent will obey forever. These checks prove that the setup works today. Run them again after every update of the guide, the bridge or the engine.

## How to report

Write the report in three parts and give it to the person in plain words:

1. What works: each check that passed, with its proof in a few words.
2. What was not checked, and why. For example: "Discord: not used" or "tools: none connected yet".
3. The next action: one action, or "nothing".

Save the report where the setup work is recorded: the setup project's LOGS.md, or today's daily memory file when there is no project. After an update, also record the result as [update.md](update.md) describes.

What to tell your person: "Everything I could test works, and here is the proof. Two things were not checked: Discord, because you do not use it, and your email, because it is not connected yet. Nothing for you to do."

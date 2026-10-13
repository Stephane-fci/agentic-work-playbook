# The way of working

This page explains why the method works the way it does. It holds no setup steps: [START-HERE.md](../START-HERE.md) has those. Each section says one idea and links to the page that holds its detail.

## Files are the memory

An agent forgets everything between conversations. Even inside one long conversation, the engine (the program that runs the model, such as Claude Code or Codex) shortens older messages to make room. The only thing that lasts is what is written in files.

So the rule is simple: if it is not written in a file, the next conversation does not know it. A decision, a preference, a lesson or the state of a piece of work exists for the agent only once it sits in the right file.

This is also why the method uses plain Markdown files (text files ending in `.md`) for nearly everything. Any person can open them, any agent can read them, and nothing is locked inside one tool. In the author's words, an agent is a folder of text files: "In the end it's just a stack of files." And: "Agents are not magic. You give it the right information, and it will get it."

## The workspace is the asset, not the agent

The workspace is the folder that holds those files: the instructions, the knowledge, the skills and the current work. Models change every few months, and engines change too. The workspace stays.

The author puts it this way: "The model is one variable, the harness is one variable, which workspace it's using is another variable." The harness in that sentence is what this guide calls the engine. Of the three, the workspace is the one you build up over time. Clean company knowledge, clear rules and good skills make any capable agent useful on its first day; a new model in a messy workspace stays confused.

Two things follow. The method works the same on every supported engine, so moving from one engine to another keeps the same workspace. And several agents can share one workspace and one memory. Two agents doing related work in separate workspaces each learn alone, which the author calls "really wasting resources".

## Boot files, read at every turn

Some knowledge the agent needs all the time: who it is, who it serves, its rules, where things go and how to talk. That knowledge lives in the boot files, the Markdown files at the top of the workspace. Every one of them is read in full at every turn (one message from the person and the agent's answer to it), not only when a conversation starts.

Every turn matters for two reasons. A boot file changed today must count from the next message, not from the next new conversation. And after the engine shortens a long conversation, the rules must still be there, whole.

On Claude Code and Codex, Agent Bridges does this: every Markdown file at the top of the workspace becomes part of the agent's instructions at every turn, fresh from disk ([adapters/agent-bridges.md](../adapters/agent-bridges.md)). The guide adopts that mechanism instead of inventing another one.

One rule follows: the top of the workspace holds boot files and nothing else. Whatever sits there costs attention at every turn, so each boot file earns its place and stays short. What each one contains is in [boot-files.md](boot-files.md). How to prove the agent really receives them is in [verify.md](verify.md).

## Progressive disclosure

The boot files do not hold everything. They hold what is always needed and point to the rest. A skill is read when a task calls for it, a project when the agent works on it, a space when its knowledge is needed. In the author's words: "we show always a bunch of information at first, that point to further information."

Everything an agent reads stays in its working memory for the rest of the conversation and takes attention from the task. So the default is to read less, while always knowing where to look. Done well, this removes most memory problems: "If I have a progressive disclosure that is good enough, I never struggle with memory." The workspace boot file, WORKSPACE.md, is the map that makes it work: it says where every kind of file lives and how to find it.

## One home per fact, and no dead information

Every kind of file has exactly one home. Lasting knowledge about a client goes in its space, a piece of work in its project, a reusable method in a skill. Because the homes are fixed, files sort themselves and every agent finds the same thing in the same place. The full map is in [workspace.md](workspace.md).

Each fact also lives in one place only. A fact written twice drifts: one copy gets updated and the other starts to lie. Other files link to the fact instead of repeating it.

And every file is linked from somewhere a new conversation will read: a boot file, an index, a project's STATE.md or a skill. A file that nothing points to is dead information. No agent will find it, or worse, one day an agent will find it and trust it after it went out of date.

## A conversation is a log, the project is the file

Conversations are where work is talked about: a chat channel, a thread, a terminal session. They scroll away, get shortened and are hard to search. The author describes a chat channel as "basically a log ... And the project is the file", and adds that "you can have work on the same project through different discord channel."

So the truth of a piece of work lives in its project folder: the goal, the decisions, the current state and the next step. Any conversation can pick the work up from there, and nothing important lives only in a chat.

## Save decisions while working

The agent writes a decision into the project's files when it is made, not at the end of the conversation. Conversations end without warning: a crash, a full context, a person who simply stops answering. Because saving is part of the work, the person never has to say "save".

The agent saves what another conversation needs to act correctly, not every thought. Before it ends a big block of work, it leaves a recovery path, so a fresh conversation can read the boot files and the project's STATE.md and continue without the person repeating anything. It also records its finished changes in Git (the version history of the workspace) in small checkpoints that name only the files it changed. Scheduled upkeep catches what a conversation still left out ([upkeep.md](upkeep.md)).

## One writer per file

When several agents share a workspace, two of them writing the same state file at the same time overwrite each other's work. So each area has one owning writer at a time. Other agents read it freely and leave changes to its owner, or wait their turn. A second agent that joins a workspace gets its own identity files and its own areas before it writes anything.

## Keep the knowledge and the boundaries, drop the procedures

Earlier versions of this method were full of procedures: boot sequences, an approval for every change, context counters in every reply, special boot files for helper agents. As models improved, the procedures got in the way more than they helped. The author: "Agents are becoming better, we don't need to prompt them too much and limit them".

What stays is what a capable agent cannot guess. First the knowledge: the person, the business, the tools, where things live and what was decided. Then the boundaries: what the agent never does on its own, such as spending, sending, publishing, deleting or deploying without the person's authorization, or writing a password into a file. Inside those boundaries the agent acts. An authorization already given counts, and the agent does not ask for the same approval twice.

A procedure stays only when it carries real operational knowledge, such as the safe way to restart a server, and then it lives in a skill, not in a boot file. Every rule is written in the fewest and simplest words, and it earns its place by preventing a real mistake. The method serves the result; it is not the result.

## Upkeep, because agents do not tidy on their own

Rules alone do not keep a workspace clean. The author found that "agents are really bad at auto organizing their job ... you say, document ... but they are not documenting." Files land in the wrong place, the memory board goes stale, a lesson stays buried in a daily note.

So small scheduled jobs do the tidying. They move stray files home, rebuild the memory board, carry lasting lessons into boot files and skills, and back everything up. Without them, a workspace drifts within weeks. Each job is a skill, and its schedule only points to that skill, so improving a job means editing one file. The jobs and their times are in [upkeep.md](upkeep.md).

## How the agent talks to the person

The person is the bottleneck. The agent reads and writes at machine speed; the person reads one line at a time and can do nothing else while reading. Every sentence spends their scarcest resource, so the agent follows a few rules:

- It puts the answer first, in one sentence, and gives the detail after it for whoever wants it.
- It uses the fewest and simplest words, and no technical terms unless the person used them first.
- It writes sentences, like a colleague talking, not walls of bullet fragments.
- It says plainly when it does not know, has only part of the data or failed, and it calls something done only after checking it.
- It closes every loop: each message gives the result, success or failure, and what happens next.
- It treats a question as a question, not as permission to act, and it asks only questions whose answer would change the result, all at once.

The complete rules ship ready to use as the shared [COMMUNICATION.md](../templates/root/COMMUNICATION.md). When the person works with agents in Discord, [discord.md](discord.md) adds a way to name channels so that both know at a glance what each one is about. That method is a Discord habit, not part of the workspace.

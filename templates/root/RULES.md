# RULES.md: {agent name}'s own rules

{Template: replace every part in braces, or delete the section if it does not apply. Delete this line when done.}

Only what belongs to this agent alone: its setup, its people's agreements and its authority. Universal behavior lives in WORKSPACE.md, OPERATING-MODE.md and COMMUNICATION.md. Each rule says who decided it and when, in a few words, with no story.

## Who decides

{The owner's name and role; the other people and what each may ask for; how each is recognized: the verified user id from the chat platform, never a display name.}

## Approvals

{Which actions need whose yes (sending, publishing, spending, deleting, deploying), and the standing permissions already given, each with who gave it and when. A standing permission is not asked for again.}

## Messages to people

{Who the agent may write to, as whom and where; whether a first message to someone new needs the owner's approval of the exact text; how the agent reports what it sent.}

## Machines and agents

{Only when there are several: which agent runs on which machine, how to reach each one, and which agent owns which area of the workspace. Check this map before connecting anywhere.}

## Models and helpers

{Which models the agent and its helpers may use, and when an independent review is required.}

## Scheduled jobs

{The time zone for every job, where reports go, who may add or change jobs. Behavior lives in each job's wf- skill, never in the schedule.}

## Team

{Team assistant only: who is on the team, their role, what each may ask for, and what the agent never does for one person on another's behalf.}

## Discord: how we work

{Optional, only if you work with agents in Discord. The method and a filled example are in the playbook's docs/discord.md. Delete this whole section if you do not use Discord.}

For every agent working in {owner}'s own Discord server. Client team servers keep their own plain names and categories; do not bring these emojis there.

A channel is where work is talked about; the project's files are the truth, and one project can span several channels. Side work goes into a thread under its channel: one emoji and two to four plain words; review threads always tag {owner}. Test channels live only in the {test emoji} {test category name} category, named `{test emoji}-<words>`, and are deleted once their evidence is saved. The server stays at {channel cap} channels at most (daily cleanup, test channels first). Mention a channel with its channel mention, never a path.

Every channel name is `<bucket emoji>-<lowercase-words>`, with at most one mark at the end. The bucket emoji says at a glance what kind of work the channel is:
- Clients: {emoji} {client name}, {emoji} {client name}.
- Own business: {emoji} {venture name and what it is}.
- Agents and own work: {emoji} the agents themselves, {emoji} scheduled workflows (any `wf-` name), {emoji} tools and skills, {emoji} repairs, {emoji} research, {emoji} {content or personal brand}, {emoji} personal life, {test emoji} tests.
- End marks, only when a mark helps: {emoji} worked on now, {emoji} open but paused, {emoji} waiting on someone, {emoji} done, {emoji} stopped, {emoji} a channel that steers other channels.
- Retired, never reuse: {emojis no longer used}.

To pick a bucket, take the first that fits: {owner}'s own word for that channel; a test goes to {test emoji}; a registered exception in the naming registry; a `wf-` name goes to the workflow bucket; work for a client or the own business takes its emoji, even when it is research or a repair; otherwise the channel's main purpose. When unsure, ask; never default to the personal bucket.

Each bucket has one Discord category: the active one holds its {20} most recently active channels, older ones go to `<emoji> <Name> Archive N` categories of up to {50}, and channels {owner} keeps outside any category stay there.

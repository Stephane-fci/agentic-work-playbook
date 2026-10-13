# The reference workspace

This page shows how the author's own workspace applies the method, every day, with real work. It describes the shape only: the agents, the files, the Discord buckets, the background jobs and the apps. Client names, ids, server addresses, server paths and credentials are left out on purpose. Some parts are older than this guide and differ from the templates; the page says where.

## One owner, one workspace, several agents

The workspace serves one owner: his consulting work for a few clients, his own ventures, his content and his personal life. Three agents work in it:

- The main agent. It owns the work and its results. It has its own identity files (`SOUL.md`, `IDENTITY.md`) and its own engine file (`AGENTS.md`), and runs on OpenClaw, the engine the workspace started on ([OpenClaw note](../adapters/openclaw.md)).
- A Claude Code operator, reached in Discord through its own [Agent Bridges](../adapters/agent-bridges.md) bot.
- A Codex operator, reached in Discord through a second Agent Bridges bot.

The operators share the owner's files and the method, not the main agent's identity. Each bridge leaves out `SOUL.md` and `IDENTITY.md` with `workspaceFiles.except`. An operator reads today's and yesterday's daily files at its first turn in a channel. The Claude Code bridge also leaves out the main agent's `AGENTS.md`, so its `CLAUDE.md` carries the full engine connection and starts by saying it is not the main agent and never claims to be. The Codex bridge leaves out `CLAUDE.md`. This is the second-operator setup described in [boot files](../docs/boot-files.md#three-profiles).

An operator executes work; the main agent stays responsible for it. Several conversations often run at once in different channels, so each area has one writer at a time, and every commit names its files by exact path instead of committing everything.

Other agents, most of them working for clients, run on their own servers with their own workspaces. They follow the same method with their own boot files; the specialists among them keep shorter versions of their own. What one agent learns about its client stays in that client's workspace. `RULES.md` holds the map of which agent runs where, checked before connecting anywhere.

## The root boot files

Thirteen files, about 118 KB in total: past the upper end of the range in [boot files](../docs/boot-files.md#writing-boot-files-well), because the agent reaches many tools and has a large skill library.

| File | Size | What it holds |
|---|---|---|
| `WORKSPACE.md` | 10 KB | the shared method: folders, where a file goes, recovery, credentials, naming |
| `OPERATING-MODE.md` | 4 KB | the shared method: how the agent decides and acts |
| `COMMUNICATION.md` | 7 KB | the shared method: how the agent talks to the owner |
| `THINKING.md` | 0.2 KB | a pointer kept from an earlier version; the guide no longer ships it |
| `SOUL.md` | 3 KB | the main agent's character (left out for the operators) |
| `IDENTITY.md` | 1 KB | the main agent's name and markers (left out for the operators) |
| `USER.md` | 6 KB | the owner: life, work, positioning, personality, his writing voice, how he likes diagrams |
| `RULES.md` | 13 KB | the map of agents and servers, the model policy for helpers, project continuity, scheduled jobs, the Discord legend, the owner's boundaries (messages to people, team messages, "urgency is not a go"), the operators' authorization, reliability rules |
| `TOOLS.md` | 30 KB | servers, where each other agent keeps its own tool map, then one table per domain: Google services, research, AI models, communication, social media, payments, websites, productivity, email marketing, infrastructure, client keys held directly |
| `MEMORY.md` | 1.5 KB | the live board: about ten active lines and the standing gates |
| `SKILLS.md` | 30 KB | more than a hundred skills, grouped by kind, each with its full description |
| `AGENTS.md` | 8 KB | the main agent's engine file |
| `CLAUDE.md` | 3 KB | the Claude Code operator's engine connection |

Two lessons show in these sizes. `RULES.md` is past the 10 KB line where rules start hiding each other, so it is the next file to trim: a new rule buried among old stories loses. `TOOLS.md` and `SKILLS.md` grow with the work; their detail belongs in each tool's skill, and they keep only the map.

## The folders

- `spaces/`: about ten, one per client, one for the own ventures, one for the agents themselves, one for personal life.
- `projects/`: more than two hundred project folders, each with `README.md`, `STATE.md` and `LOGS.md`. Long work carries a roadmap package. Inactive projects move to `archives/`.
- `repositories/`: about fifty registered repositories (below).
- `dashboards/`: eight records of running apps.
- `skills/`: more than a hundred skills, with the prefixes from [skills](../docs/skills.md).
- `resources/`, `memory/` and `archives/` as in [workspace](../docs/workspace.md).

## Repositories and dashboards

Every app the agents build gets its own repository and, once it runs, a dashboard record. Among them: the Discord bridge itself, a live map of the workspace, a board of business ideas, a trends research tool, a permissions console, a creator programme for a client, a prototype voice book for babies and a private 3D globe. Most apps run in their own package on a server, behind a login when they are private. Its secrets live in protected files on the server, outside the workspace.

The workspace's own Git history ignores the repository folders: each has its own history and a private remote. `repositories/INDEX.md` is the tracked map. One entry looks like this (the app here is made up):

```markdown
### order-tracker

- Local: `repositories/order-tracker/`, branch `main`.
- Remote: a private repository on the owner's account.
- Owner: `projects/order-tracker/`, and the Discord channel where it is discussed.
- What it holds: the tracker's web app, its database setup and its tests.
- Deployment: where it runs, its address and who can open it.
- Operations: `repositories/order-tracker/OPERATIONS.md`; record `dashboards/order-tracker/README.md`.
```

## Discord: fifteen buckets

The owner's own server uses the emoji method from [discord.md](../docs/discord.md), with fifteen buckets of three kinds:

- Clients: four, each with its own emoji, chosen among animals and fruit so none looks like a kind of work.
- Own ventures: one, 🐝, for the owner's own businesses, the ones running and the ones still to build.
- Kinds of work: ten. 🤖 the agents themselves, ⚙️ scheduled workflows, 🥑 tools and skills, 🔧 repairs, 🔎 research, 🧧 YouTube and personal brand, 🎥 one channel per video idea, 🐔 personal life, 🪖 army, 🧪 tests.

The six end marks are the ones in [discord.md](../docs/discord.md#end-marks), and eight retired emojis are never reused. The legend sits in `RULES.md`. The registry (category ids, the name parts that mean each client, the exceptions and the history) sits in the channel-naming skill's `CONTEXT.md`. Each bucket has an active category of 20 channels and archives of 50. The server stays under 400 channels through the nightly cleanup. The clients' own servers keep their plain layout, by person or by function.

## Background jobs

The times are in the owner's time zone (Central European). The jobs run from three schedulers: the main agent's own scheduler, server timers (some of them wake an operator), and the bridge for its engine updates. Each job lives in exactly one of them and points to its `wf-` skill. Most report in their own ⚙️ channel.

Upkeep, as in [upkeep](../docs/upkeep.md):

| When | Job | What it does |
|---|---|---|
| daily 01:40 | storage check | watches the disk and frees only what is approved as safe to rebuild |
| daily 02:10 | workspace tidy | moves stray files to their homes and keeps the root clean |
| daily 02:50 | git backup | commits and pushes the workspace to a private repository |
| daily 03:15 | nightly harvest | saves the day's decisions into their files and rebuilds the board |
| daily 03:20 | channel cleanup | keeps the server under 400 channels, saving each channel before deleting it |
| Sunday 04:30 | memory reflection | moves lasting lessons into boot files and skills, archives old daily files |
| 1st of the month, 10:00 | job audit | checks that jobs, skills and report channels still match; changes nothing |

Machinery around the agents:

| When | Job | What it does |
|---|---|---|
| every 3 hours | login renewal | renews engine logins before they expire |
| daily 05:15 | snapshot check | checks that the servers' snapshots exist and are fresh |
| daily 06:20 | model accounts check | checks the shared pool of model accounts the agents use |
| Monday 08:15 | security audit | read-only check of the server, and what changed since last week |
| Monday 09:00 | security summary | one line-up of every agent's security audit |
| Sunday 23:00 | engine update elsewhere | updates Claude Code on servers the bridge does not manage |
| Sunday 03:30 and daily 04:30, server time | bridge updates | the bridge tests a new engine version, then switches at its quiet daily restart |

Business jobs:

| When | Job | What it does |
|---|---|---|
| daily 08:15 | client agent summary | a morning summary of one client agent's state |
| daily 23:30 | time logging | logs the day's client hours in the time tracker |
| every 30 minutes | meeting watcher | wakes an operator when a new recorded meeting arrives, to file it |
| Monday 08:35 | community watch | finds new lessons in a paid community the owner follows |
| Monday 09:00 | client bills sync | files a client's tool invoices from an inbox into its accountant's sheet |
| 1st and 15th, 09:20 | strategy source watch | adds new videos from a strategy author to the skill built from his work |
| 2nd of the month, 08:00 | invoicing and tax close | client invoices, tax declarations, the business table and the household budget |

Nothing here depends on the owner typing "save": the save-while-working rule, the nightly harvest and the weekly reflection keep the files current ([upkeep](../docs/upkeep.md#you-never-have-to-say-save)).

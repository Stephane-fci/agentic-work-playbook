# Agentic Work Playbook

This guide teaches an AI agent how to work for you: where it keeps what it learns, which instruction files it reads at every message, how its workspace stays tidy, and how to prove it all works. You give the guide to your agent, and the agent sets itself up, explaining each step to you in plain words as it goes.

## What you get

- An agent that remembers. Decisions and work in progress live in plain text files, so a new conversation picks up where the last one stopped.
- A tidy workspace: one place for each kind of thing, from what the agent knows about your business to its daily diary.
- Instruction files written for you: who you are, how you work, what the agent may do on its own, and its tools.
- Background jobs that tidy, save and back up the workspace every night, so you never have to say "save".
- A final check with real proof of what works, not the agent's word for it.
- Optional: a simple way to name Discord channels, so you see at a glance what each one is about.

It works for your own assistant, a team assistant, or a specialist with one job.

## What you need

- An AI agent running on Claude Code or Codex. The engine is the program that runs the AI model and lets it work with files and tools.
- Ideally, Agent Bridges in front of it: you talk to the agent in Discord or Slack, and it receives all its instruction files fresh at every message ([adapters/agent-bridges.md](adapters/agent-bridges.md)). Without it the guide still works, but a changed instruction file counts only from the next new conversation.
- A folder for the agent's workspace, on a computer or a server where the agent runs. A workspace already in use is fine: the agent completes it and never overwrites your own files.
- For the nightly backup, a private online copy of that folder that you own, such as a private GitHub repository. The agent helps you make it.

## The one sentence to give your agent

```text
Read START-HERE.md in https://github.com/Stephane-fci/agentic-work-playbook and set yourself up.
```

Send the link, not a zip file by email: mail servers often block zip files that contain scripts.

The agent reads the guide, looks at what you have, and asks one short set of questions only you can answer. On a workspace already in use, it shows you the list of changes and waits for your yes. Then it sets itself up, tests itself and reports what works, what was not checked, and the next action.

## How long it takes

Plan for an afternoon for the core setup. The agent does the work; your part is about an hour: answering the questions, saying yes to the changes and reading the report. The final check alone takes about half an hour ([docs/verify.md](docs/verify.md)).

Connecting your tools and proving each background job with a real run often takes a few more days; the report says plainly what is still open. Get the agent running and reachable first: setups stall when the server, the chat connection and this guide are all done at once.

## What this guide is not

It sets up how the agent works, not the things around it. Each of these is a separate product:

- The server: buying, securing and maintaining it. The author's separate guide: https://github.com/Stephane-fci/vps-hardening-playbook
- The chat connection: installing Agent Bridges and its Discord bot, which has its own install guide.
- A permission system that controls what each member of a team may ask the agent.
- Skill Forge, a skill that creates, audits and retires skills once the library grows. The skill method in this guide works without it.

It does not install Claude Code or Codex, and it does not create your accounts or logins.

## The guide's files

- [START-HERE.md](START-HERE.md): the setup, for your agent.
- [docs/way-of-working.md](docs/way-of-working.md): the method and why.
- [docs/workspace.md](docs/workspace.md): the folders, and what goes where.
- [docs/boot-files.md](docs/boot-files.md): every instruction file.
- [docs/skills.md](docs/skills.md): the agent's reusable abilities.
- [docs/upkeep.md](docs/upkeep.md): the background jobs and commands.
- [docs/discord.md](docs/discord.md): optional, naming Discord channels.
- [docs/verify.md](docs/verify.md): the final check.
- [docs/update.md](docs/update.md): moving to a new version safely.
- [adapters/](adapters/): Agent Bridges, Claude Code, Codex, and existing OpenClaw agents.
- [templates/](templates/): the starting files.
- Examples: [examples/personal-assistant/](examples/personal-assistant/) and [examples/team-assistant/README.md](examples/team-assistant/README.md), both fictional, and [examples/reference-workspace.md](examples/reference-workspace.md), the shape of the author's own workspace.
- [checks/](checks/): a read-only structure check.
- [CHANGELOG.md](CHANGELOG.md): what changed, and why.

To update later, tell your agent: "Update the playbook by following docs/update.md."

## Author and version

Written by Stephane Franceschini (Steph France), from how he works with his own agents every day: https://www.youtube.com/@steph_france

The current version is the one line in [VERSION](VERSION).

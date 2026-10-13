# OpenClaw: existing workspaces only

This guide no longer covers setting up a new OpenClaw agent. This page is for someone who already runs one and wants to keep the method working, or to move to Claude Code or Codex. The facts were checked against OpenClaw's official documentation in October 2026.

## What OpenClaw loads by itself

OpenClaw injects `AGENTS.md`, `SOUL.md`, `IDENTITY.md`, `USER.md` and `MEMORY.md` at every run; `MEMORY.md` only in the main private conversation. Helper sessions get only `AGENTS.md`. Sources: https://docs.openclaw.ai/concepts/system-prompt and https://docs.openclaw.ai/concepts/agent-workspace

`TOOLS.md`, `RULES.md`, `WORKSPACE.md` and the guide's other boot files are not loaded by name. Today's and yesterday's daily memory files are added only once after `/new` or `/reset`, within a small size budget. Source: https://docs.openclaw.ai/gateway/config-agents/workspace-and-bootstrap

By default each file is cut at 20,000 characters and all of them together at 60,000 (`agents.defaults.bootstrapMaxChars` and `bootstrapTotalMaxChars` raise this). `USER.md` has a fixed ceiling of 4,000 characters that no setting can raise. Sources: https://docs.openclaw.ai/gateway/config-agents/workspace-and-bootstrap and https://docs.openclaw.ai/concepts/user-model

## Adding the other boot files

The bundled `bootstrap-extra-files` hook accepts only the standard file names above, so it cannot add `RULES.md` and the others (https://docs.openclaw.ai/automation/hooks/bundled-hooks). A small custom hook on the `agent:bootstrap` event can append the other top-level files to the list OpenClaw injects (https://docs.openclaw.ai/automation/hooks/writing-hooks). Raise the two size settings above the size of your files.

Check with `/context list` in a private conversation: it shows every injected file with its size and whether it was cut. Source: https://docs.openclaw.ai/concepts/context

One warning: `openclaw doctor --fix` archives a top-level `TOOLS.md` and merges its content into `AGENTS.md` (https://docs.openclaw.ai/automation/hooks/bundled-hooks). Look at what it will change before running it on a workspace that follows this guide.

## Moving to Claude Code or Codex

The workspace stays the same: its files, skills and memory do not move. Install [Agent Bridges](agent-bridges.md) with `--workspace` pointing at the existing folder. The bridge then delivers every top-level Markdown file at every turn, which OpenClaw did only for some of them.

An OpenClaw `AGENTS.md` often describes OpenClaw's own mechanics. Move those parts out, or leave `AGENTS.md` out of a Claude Code bridge with `workspaceFiles.except`. While both agents run on the same folder, each bridge leaves out the other agent's identity files, and each area keeps one writer at a time ([way of working](../docs/way-of-working.md)).

# Working with agents in Discord

This page is optional. Use it if you talk to your agents in Discord. It is a Discord habit only: it names and sorts channels so you see at a glance what each one is about. It does not change how the workspace is organized, and the files stay the truth ([workspace](workspace.md)).

The connection between Discord and your agent is a separate product. [Agent Bridges](../adapters/agent-bridges.md) is the recommended one: each channel and each thread is one long conversation with the agent.

On the person's side, Discord in the browser can be set up for this way of working with AgentDisc, a Chrome extension by the same author: https://github.com/Stephane-fci/agentdisc. It follows the method on this page: it treats a category and its `Archive N` categories as one family, its new-channel box puts the chosen category's emoji at the start of the name, and one shortcut moves a loose channel into its family's active category. It also shows which agent is typing in which thread. Its feedback mode quotes a piece of the agent's message as *"the quoted text"* >> followed by the person's answer: the agent answers each quote. The method works without it.

## Channels, threads and tests

A channel is where a topic is talked about. The project's files hold the truth, so decisions go into them while you work, not only into the chat. One project can be discussed in several channels, and one channel can touch several projects. A channel's topic line can name the project it serves.

Side work goes into a thread under its channel, so the main conversation stays short and fast. Name a thread with one emoji and two to four plain words that say what it is about, like "🛒 Stock shown wrong" or "🧾 Invoice layout". No codes, ids or labels such as "Fix:".

A thread shows in a person's sidebar once they have joined it, and a tag adds them. So when a thread needs a person, tag them in its first message. A review thread always tags the owner.

Tests get their own category. Create every test channel there from the start, named with the test emoji, like `🧪-checkout-test`. When the test is done, save its evidence (the result, the screenshots that matter) in the project that owns the work, then delete the channel. Working channels never host tests.

Discord allows at most 500 channels per server. Categories count toward that number; threads do not. Keep your own lower cap, for example 400, so there is always room. A daily cleanup job keeps the server under it: test channels go first, then the channels with the oldest activity. Before it deletes a channel, it saves a full copy of it (messages and files) in the workspace, and a channel it cannot fully save stays. The job is described in [upkeep](upkeep.md).

To point at a channel, use its channel mention: type `#` and pick it (agents write `<#channel id>`). A mention is a link that opens the channel; a path or a name in plain text is not. To make sure a person sees something, tag them.

## The emoji method

Every channel name starts with one bucket emoji, then lowercase words joined by hyphens, with an optional mark at the end:

```text
<bucket emoji>-<lowercase-words>[-<end mark>]
```

The bucket emoji says what kind of work the channel holds: a client, your own business, or a kind of work such as research or repairs. For example `🥐-maple-menu-photos` is work for a bakery client, and `🔎-agent-memory-methods` is research.

### End marks

A channel can carry one mark at the end of its name, only when the mark helps:

- ⚡ worked on now
- ⌛ open but paused
- ⏸️ waiting on someone
- ✅ done
- ❌ stopped
- 🧠 a channel that steers other channels

The first five say where the work stands. 🧠 is different: it says the channel coordinates other channels, not how far the work is.

One mark at most. If two seem to fit, keep the one that matters most to the reader; the full state lives in the project's STATE.md. Do not mark every channel out of habit, and never put an end mark at the start of a name.

### Picking a bucket

Take the first rule that fits:

1. The owner's own word for that channel.
2. A test goes to the test bucket.
3. A registered exception: a channel the owner placed somewhere on purpose, written down in the registry (see below).
4. A name that starts with `wf-` (a scheduled workflow) goes to the workflow bucket, even when a client name follows.
5. Work for a client or for your own business takes that bucket, even when it is research or a repair.
6. Otherwise, the channel's main purpose: the agents themselves, tools and skills, repairs, research, content, personal life.

When unsure, the agent asks the owner one short question. Unknown work never goes into the personal bucket: personal means personal life, not "everything else". When renaming an old channel, classify it from what it is about, not from the emoji it already carries.

### Pictures are not buckets

Only the first emoji of a channel name is a bucket. The emoji at the start of a thread name is a picture of its topic: it never moves the thread to another client or another folder. Emojis in roadmaps, reports and cards are pictures too.

Pictures may repeat freely. Buckets may not: each bucket emoji means one thing on the server.

### One category per bucket

Each bucket has one Discord category (a folder in the sidebar):

- The active category, named with the emoji and the bucket's name, like `🥐 Maple Street Bakery`, holds the bucket's 20 most recently active channels.
- Older channels go to archive categories named `<emoji> <Name> Archive N`, like `🥐 Maple Street Bakery Archive 1`, each holding up to 50 channels. A new archive starts only when the others are full.
- Inside every category, channels are sorted by their last message, newest at the top.
- Channels the owner keeps outside any category stay there. Many owners keep a short focus list of loose channels at the top of the sidebar, and a sorting pass never pulls them into a category.

An archive category is only storage in the sidebar. It does not mean the work is done, and its channels still work as before.

### Changing names safely

Renaming and sorting need the bot to have Discord's Manage Channels permission. A rename keeps the channel's history and its id. Before renaming or moving many channels at once, the agent shows the list of current and new names and waits for the owner's yes. A question about names is not a request to rename.

Keep a short list of retired emojis that are never reused, so an old channel name is never misread.

## Build your own bucket list

1. List your clients. Each one gets its own emoji, easy to recognize.
2. List your own businesses or ventures. Each one you work on for a long time gets its own emoji.
3. List the kinds of work you do with agents: work on the agents themselves, scheduled workflows, tools and skills, repairs, research, content and personal brand, personal life, tests. Keep only the ones you use, but keep the workflow bucket whenever your background jobs report in Discord channels: each job has its own channel ([upkeep](upkeep.md)), and those channels need a bucket.
4. Pick one distinct emoji per bucket. Avoid emojis that look alike, and keep the end marks out of the bucket list.
5. Write the legend in RULES.md, in a section called "Discord: how we work". RULES.md is a boot file, so every agent knows the legend at every turn ([boot files](boot-files.md)). The RULES.md template in [templates](../templates/) has the section ready.
6. If you need more detail, keep it in one registry: the category names and ids, the name parts that mean a client (for example `maple-`), the exceptions and the history of changes. The CONTEXT.md of a channel-naming skill is a good home ([skills](skills.md)). The legend in RULES.md stays the one list of meanings: change a bucket there first, then in the registry.
7. Add a bucket only when a new client, venture or lasting kind of work appears. A bounded project does not get its own emoji.

### A fictional example legend

Here is the section for a made-up owner with two clients (a bakery and a fitness app) and a small online shop of their own. Every name in it is invented.

```markdown
## Discord: how we work

For every agent working in the owner's own Discord server. Client team servers keep their own plain names and categories; do not bring these emojis there.

A channel is where work is talked about; the project's files are the truth, and one project can span several channels. Side work goes into a thread under its channel: one emoji and two to four plain words; review threads always tag the owner. Test channels live only in the 🧪 Tests category, named `🧪-<words>`, and are deleted once their evidence is saved. The server stays at 400 channels at most (daily cleanup, test channels first). Mention a channel with its channel mention, never a path.

Every channel name is `<bucket emoji>-<lowercase-words>`, with at most one mark at the end. The bucket emoji says at a glance what kind of work the channel is:
- Clients: 🥐 Maple Street Bakery, 💪 PulseFit (fitness app).
- Own business: 🌱 Fernway, the owner's online plant shop.
- Agents and own work: 🤖 the agents themselves (building, improving, running them), ⚙️ scheduled workflows (any `wf-` name), 🧰 tools and skills, 🔧 repairs, 🔎 research, 🎙️ podcast and personal brand, 🏡 personal life, 🧪 tests.
- End marks, only when a mark helps: ⚡ worked on now, ⌛ open but paused, ⏸️ waiting on someone, ✅ done, ❌ stopped, 🧠 a channel that steers other channels.
- Retired, never reuse: 📁 🚀.

To pick a bucket, take the first that fits: the owner's own word for that channel; a test goes to 🧪; a registered exception in the naming registry; a `wf-` name goes to ⚙️; work for a client or the own business takes its emoji, even when it is research or a repair; otherwise the channel's main purpose. When unsure, ask; never default to 🏡.

Each bucket has one Discord category: the active one holds its 20 most recently active channels, older ones go to `<emoji> <Name> Archive N` categories of up to 50, and channels the owner keeps outside any category stay there.
```

### How names come out

With that legend:

- New menu photos for the bakery: `🥐-maple-menu-photos`.
- Research on the bakery's local competitors: `🥐-maple-competitors`. Client work stays with the client, even when it is research.
- A daily job that posts PulseFit sign-ups, named `wf-pulsefit-signups`: `⚙️-wf-pulsefit-signups`. The `wf-` rule comes before the client rule; the project still records that it serves PulseFit.
- A test of the bakery's checkout: `🧪-maple-checkout-test`, in the Tests category, deleted once the result is saved in the bakery's project.
- The nightly backup keeps failing: `🔧-nightly-backup`.
- Comparing ways to give agents a memory: `🔎-agent-memory-methods`.
- A new skill that drafts invoices: `🧰-invoice-skill`.
- The channel that coordinates the PulseFit launch channels: `💪-pulsefit-launch-🧠`.
- The shop's launch, being worked on right now: `🌱-fernway-launch-⚡`.
- A thread "🛒 Stock shown wrong" under `🌱-fernway-launch-⚡`: still the shop's work. The 🛒 is a picture.
- A channel nobody can place: the agent asks the owner. It does not go to 🏡.

## Client team servers

When an agent also works in a client's own Discord server, that server keeps its own plain layout: plain channel names and categories by person or by function, the way the team set them up. Do not bring your emoji legend there. The method is for your own server.

## Check

[Verify](verify.md) asks the agent to classify a few made-up channels. It passes when the agent picks the right bucket for each, names the rule it used, and treats a thread's emoji as a picture, not a bucket.

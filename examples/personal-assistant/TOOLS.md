# TOOLS.md: what Nora can reach

Every tool gets four things: what it does, where its credential is kept (the place, never the value), which skill to read first, and when it was last checked. A tool counts as connected only after a real read-only check. If a skill is named, read it before the first call.

## The machine

Nora runs on a small rented Linux server as the user `nora`, without admin rights. The workspace is `/home/nora/workspace`. Secrets live in `/home/nora/.secrets/`, readable by `nora` only, outside the workspace and outside its backup. The engine is Claude Code, connected to Alex's Discord server through Agent Bridges.

## Connected and proven

| Tool | What it does | Credential kept in | Skill to read first | Last checked |
|---|---|---|---|---|
| Shopify (Fernway store) | orders, products and stock; changes only under RULES.md | `/home/nora/.secrets/shopify-fernway.json` | platform-shopify | 2026-03-10 |
| Gmail (shop address) | read, label and draft; sends under RULES.md | `/home/nora/.secrets/google-fernway.json` | platform-gmail | 2026-03-10 |
| Google Calendar (Alex) | read and edit Alex's own calendar | the same Google login | none | 2026-03-10 |
| Google Drive and Sheets | the shop's costs, suppliers and stock count | the same Google login | platform-google-sheets | 2026-03-04 |
| Carrier tracking | delivery status of a parcel | `/home/nora/.secrets/carrier-tracking.json` | none | 2026-02-28 |
| Discord | conversations with Alex, through the bridge | the bridge's own settings, managed by the bridge | none | 2026-03-12 |
| GitHub | private backup of the workspace, repository `fernway-workspace` on Alex's account | `/home/nora/.secrets/github-backup-key` | none | 2026-03-12 |

Shopify: the stock shown in the admin includes reserved items; the skill says how to read the real free stock.

## Planned, not connected

| Tool | Why it is wanted | State |
|---|---|---|
| Klaviyo | the Fernway newsletter and its email flows; today Alex sends by hand | waiting for Alex to create a read-only key |
| Meta Ads | read the results of the spring campaign | not started; Alex decides in April |

## Not allowed

Alex's personal bank and the shop's payout settings: never, not even to read. The clients' own accounts: Nora works from the exports and shared folders the clients give, never with their logins (Alex, 8 Jan 2026).

## Adding a tool

Read the official documentation. Ask Alex for the smallest access that does the job. Alex pastes the key in the working channel and deletes the message once Nora confirms it is saved in `/home/nora/.secrets/`. Test read-only first, record the tool here with the date, and propose any write only after that.

Pitfalls of a tool live in its skill. A tool without a skill keeps at most one warning line here.

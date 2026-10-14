# Stilltone MCP examples

**Connect Claude, Cursor and other MCP apps to your meetings.** Stilltone ships a local
[Model Context Protocol](https://modelcontextprotocol.io) server with 21 tools. AI apps can search your meetings, read
decisions, action items and open questions with their sources, and update them (name speakers, tag meetings, mark
action items done, add notes). The server runs on your Mac and works on your meeting files directly.

- Ready-to-use configs: [`configs/`](configs) for Claude Desktop, Claude Code and Cursor
- The full tool reference: below
- A prompt library: [`prompts.md`](prompts.md)

## Requirements
- [Stilltone](https://stilltone.app) for Mac (macOS 15 or later, Apple silicon), with at least one meeting
- An MCP client: Claude Desktop, Claude Code, Cursor or any app that supports MCP over stdio
- In Stilltone: **Settings → Connections → Local MCP server** turned on

The server is the command-line tool that ships inside the app:
`/Applications/Stilltone.app/Contents/Helpers/stilltone mcp serve`. To print the exact snippets for your Mac, run:

```sh
/Applications/Stilltone.app/Contents/Helpers/stilltone mcp install
```

## Set up
### Claude Desktop
Open Claude → Settings → Developer → *Edit Config*, merge [`configs/claude_desktop_config.json`](configs/claude_desktop_config.json)
into `claude_desktop_config.json`, then restart Claude. "stilltone" appears in the tools menu.

### Claude Code
```sh
claude mcp add --scope user stilltone -- /Applications/Stilltone.app/Contents/Helpers/stilltone mcp serve
```
(or run [`configs/claude-code.sh`](configs/claude-code.sh)). Check with `claude mcp list`.

### Cursor
Copy [`configs/cursor-mcp.json`](configs/cursor-mcp.json) to `~/.cursor/mcp.json` (all projects) or `.cursor/mcp.json`
in one project, then enable *stilltone* in Cursor Settings → MCP.

### Other MCP clients
Command `/Applications/Stilltone.app/Contents/Helpers/stilltone`, arguments `mcp serve`, transport stdio. No API key, no
network port.

## Tools
**Read (14)**

| Tool | What it returns |
|---|---|
| `search_meetings` | Meetings matching free text across title, summary and transcript; filters: since/until, participant, project |
| `ask_meetings` | An answer to a question across all meetings, citing Date · Title [MM:SS], with the meetings it used |
| `list_decisions` | Decisions across meetings with their meeting; filters: project, since/until |
| `list_action_items` | Action items across meetings with meeting, owner (and whether the owner was stated) |
| `list_open_questions` | Unresolved questions in a meeting, with source timestamps |
| `list_risks` | Risks and blockers in a meeting (severity, owner, timestamp) |
| `list_people` | People across meetings (participants + named speakers), with meeting and open-item counts |
| `find_mentions` | Transcript segments mentioning a term, across all meetings |
| `get_meeting_summary` | A meeting's summary |
| `get_transcript_segments` | A meeting's timestamped transcript (speaker, start, end, text) |
| `get_follow_up_draft` | The follow-up draft for a meeting (a draft for review; never sent) |
| `get_meeting_metadata` | Title, dates, participants, tags, type, project, models |
| `get_meeting_tags` | A meeting's topic tags |
| `list_meetings_by_type` | Meetings of a type (standup, 1-on-1, retrospective…), newest first |

**Write (7)** — every change goes through the meeting's own files, the same way the app writes them

| Tool | What it changes |
|---|---|
| `set_speaker_name` | Names a speaker in a meeting and re-renders the transcript |
| `set_meeting_participants` | Replaces a meeting's participant list |
| `set_meeting_tags` | Replaces a meeting's topic tags |
| `set_meeting_type` | Sets a meeting's type |
| `set_meeting_project` | Sets or clears a meeting's project |
| `mark_action_done` | Marks an action item done or not done |
| `add_meeting_note` | Appends a note to a meeting, optionally at a time in the meeting |

## Privacy
The MCP server runs on your Mac and reads your meeting files there; it opens no network port. The AI app you connect
receives the meeting content it asks for, and that app's own privacy terms apply from there. If your client runs a
cloud model, what it reads goes to that model.

## Troubleshooting
| Symptom | Fix |
|---|---|
| The client shows no "stilltone" tools | Check the path exists: `ls /Applications/Stilltone.app/Contents/Helpers/stilltone`. Restart the client after editing its config. |
| "Server disconnected" right away | Turn on Settings → Connections → Local MCP server in Stilltone, then retry. |
| Tools work but find nothing | Stilltone has no processed meetings yet, or the meeting is still processing. |
| You moved the app | Run `… stilltone mcp install` again and update the path in your config. |
| Check the server by hand | `/Applications/Stilltone.app/Contents/Helpers/stilltone --version` prints the app version. |

## Links
[stilltone.app](https://stilltone.app) · [MCP in Stilltone](https://stilltone.app/integrations/mcp) ·
[Obsidian templates](https://github.com/stilltone-app/obsidian-templates) · [support@stilltone.app](mailto:support@stilltone.app)

## License
[MIT](LICENSE)

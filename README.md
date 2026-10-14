# Stilltone MCP examples

Connect Claude, Cursor and other MCP clients to Stilltone's local MCP server: search your meetings and read decisions,
action items and open questions with their sources, and update them. The server runs on your Mac.

1. In Stilltone, turn on **Local MCP server** (Settings → Connections).
2. Run `/Applications/Stilltone.app/Contents/Helpers/stilltone mcp install`: it prints these snippets with the path on your Mac.

## Claude Desktop — `claude_desktop_config.json`
```json
{ "mcpServers": { "stilltone": { "command": "/Applications/Stilltone.app/Contents/Helpers/stilltone", "args": ["mcp", "serve"] } } }
```

## Claude Code
```
claude mcp add stilltone -- /Applications/Stilltone.app/Contents/Helpers/stilltone mcp serve
```

## Cursor — `.cursor/mcp.json`
Same `mcpServers` block as Claude Desktop.

## Example prompts
- "List every decision about pricing from the last month, with the meeting each came from."
- "Which action items assigned to me are still open?"
- "Mark the pricing-page action item as done."

More: https://stilltone.app/integrations/mcp

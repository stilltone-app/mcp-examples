#!/usr/bin/env bash
# Add Stilltone's local MCP server to Claude Code (user scope: available in every project).
claude mcp add --scope user stilltone -- /Applications/Stilltone.app/Contents/Helpers/stilltone mcp serve

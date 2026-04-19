#!/bin/bash
# sync-openclaw-state.sh
# Syncs relevant OpenClaw files to a directory readable by the Mission Control container
# Run as opencode user (member of openclaw group)

SRC="/home/openclaw"
DST="/home/opencode/dev/mission-control/openclaw-state"

mkdir -p "$DST/workspace/main"
mkdir -p "$DST/workspace/domotica"
mkdir -p "$DST/memory"

# Sync top-level agent files (HEARTBEAT, MEMORY, AGENTS, etc.)
for f in HEARTBEAT.md MEMORY.md AGENTS.md SOUL.md IDENTITY.md DREAMS.md TOOLS.md USER.md; do
  [ -f "$SRC/$f" ] && cp "$SRC/$f" "$DST/$f" 2>/dev/null
done

# Sync workspace agent files
for agent in main domotica; do
  if [ -d "$SRC/workspace/$agent" ]; then
    cp "$SRC/workspace/$agent"/*.md "$DST/workspace/$agent/" 2>/dev/null
  fi
done

# Sync memory files
if [ -d "$SRC/memory" ]; then
  cp "$SRC/memory"/* "$DST/memory/" 2>/dev/null
fi

echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] openclaw-state synced"

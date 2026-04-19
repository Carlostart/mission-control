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
# Copy to both root (for Mission Control detection) and workspace/main/
for f in HEARTBEAT.md MEMORY.md AGENTS.md SOUL.md IDENTITY.md DREAMS.md TOOLS.md USER.md; do
  if [ -f "$SRC/$f" ]; then
    cp "$SRC/$f" "$DST/$f" 2>/dev/null
  elif [ -f "$SRC/workspace/main/$f" ]; then
    cp "$SRC/workspace/main/$f" "$DST/$f" 2>/dev/null
  fi
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

# Copy openclaw module for version detection inside container
OPENCLAW_MOD="$SRC/.nvm/versions/node/v22.22.2/lib/node_modules/openclaw"
if [ -d "$OPENCLAW_MOD" ]; then
  mkdir -p "$DST/openclaw-module"
  # Only copy the files needed for --version (entry + dist, skip node_modules)
  cp "$OPENCLAW_MOD/openclaw.mjs" "$DST/openclaw-module/" 2>/dev/null
  if [ -d "$OPENCLAW_MOD/dist" ]; then
    cp -r "$OPENCLAW_MOD/dist" "$DST/openclaw-module/" 2>/dev/null
  fi
  chmod -R 755 "$DST/openclaw-module" 2>/dev/null
fi

echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] openclaw-state synced"

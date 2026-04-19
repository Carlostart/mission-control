#!/bin/sh
# openclaw-bin.sh — wrapper for Mission Control runtime detection
# Uses node from the container + openclaw module mounted from openclaw-state/
exec node /run/openclaw/openclaw-module/openclaw.mjs "$@"

#!/bin/bash
set -e

PUID=${PUID:-1001}
PGID=${PGID:-100}

# Adjust user/group IDs at runtime for Unraid compatibility
if [ "$(id -u camoufox)" != "$PUID" ] || [ "$(id -g camoufox)" != "$PGID" ]; then
    groupmod -o -g "$PGID" users 2>/dev/null || true
    usermod -o -u "$PUID" -g "$PGID" camoufox 2>/dev/null || true
    chown -R camoufox:users /home/camoufox
fi

exec gosu camoufox python3 /home/camoufox/launch_server.py

#!/bin/bash
set -e

PUID=${PUID:-1001}
PGID=${PGID:-100}

# Adjust user/group IDs at runtime for Unraid compatibility
if [ "$(id -u camoufox)" != "$PUID" ] || [ "$(id -g camoufox)" != "$PGID" ]; then
    groupmod -o -g "$PGID" camoufox 2>/dev/null || true
    usermod -o -u "$PUID" camoufox 2>/dev/null || true
    chown -R camoufox:camoufox /home/camoufox
fi

# Virtual display for anti-detection (better than headless mode)
Xvfb :99 -screen 0 1920x1080x24 &
export DISPLAY=:99

exec gosu camoufox python3 /home/camoufox/launch_server.py

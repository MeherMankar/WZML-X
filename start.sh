#!/bin/bash
set -e

# Use Heroku's dynamic PORT or fallback to 8080
export BASE_URL_PORT=${PORT:-8080}

# Activate virtualenv — /wzvenv is used in the Docker image
if [ -f "/wzvenv/bin/activate" ]; then
  source /wzvenv/bin/activate
elif [ -f ".venv/bin/activate" ]; then
  source .venv/bin/activate
fi

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Run update script only if UPSTREAM_REPO is configured
if [ -f "update.py" ] && [ -n "$UPSTREAM_REPO" ]; then
  python3 update.py
fi

# Start the bot (setpkgs.sh inside the bot handles aria2/sabnzbd startup)
exec python3 -m bot

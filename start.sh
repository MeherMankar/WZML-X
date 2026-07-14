#!/bin/bash
set -e

# Use Heroku's dynamic PORT or fallback to 8080
export BASE_URL_PORT=${PORT:-8080}

# Start aria2 RPC daemon
aria2c \
  --enable-rpc \
  --rpc-listen-all=false \
  --rpc-listen-port=6800 \
  --allow-overwrite=true \
  --auto-file-renaming=false \
  --max-concurrent-downloads=10 \
  --continue=true \
  --check-certificate=false \
  --daemon=true \
  --quiet=true \
  --summary-interval=0

echo "[START] aria2 started"

# Activate virtualenv if it exists (for Heroku/uv builds)
if [ -f ".venv/bin/activate" ]; then
  source .venv/bin/activate
fi

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Run update script if it exists
if [ -f "update.py" ]; then
  python3 update.py
fi

# Start the bot
exec python3 -m bot

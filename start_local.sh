#!/bin/bash

# Kill any leftover processes from previous run
pkill aria2c 2>/dev/null
pkill gunicorn 2>/dev/null
pkill -f "python3.12 -m bot" 2>/dev/null
sleep 1

# Start aria2 RPC server
aria2c --enable-rpc \
  --rpc-listen-all=false \
  --rpc-listen-port=6800 \
  --allow-overwrite=true \
  --auto-file-renaming=false \
  --max-concurrent-downloads=10 \
  --continue=true \
  --daemon=true \
  --log=/tmp/aria2.log

echo "aria2 started"
sleep 2

# Check aria2 is running
if ! pgrep aria2c > /dev/null; then
    echo "ERROR: aria2 failed to start. Check /tmp/aria2.log"
    exit 1
fi

# Add local bin to PATH for gunicorn etc.
export PATH="$HOME/.local/bin:$PATH"

# Start the bot
echo "Starting bot..."
python3.12 -m bot

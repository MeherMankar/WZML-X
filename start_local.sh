#!/bin/bash

# Kill any leftover processes from previous run
pkill aria2c 2>/dev/null
pkill gunicorn 2>/dev/null
pkill qbittorrent-nox 2>/dev/null
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
  --check-certificate=false \
  --daemon=true \
  --quiet=true \
  --summary-interval=0

echo "[START] aria2 started"

# Configure qBittorrent with known credentials and bypass localhost auth
QB_CONF_DIR="$HOME/.config/qBittorrent"
mkdir -p "$QB_CONF_DIR"
cat > "$QB_CONF_DIR/qBittorrent.ini" << 'QBCONF'
[BitTorrent]
Session\DefaultSavePath=/tmp/downloads/

[LegalNotice]
Accepted=true

[Preferences]
WebUI\AuthSubnetWhitelistEnabled=true
WebUI\AuthSubnetWhitelist=127.0.0.1/32
WebUI\LocalHostAuth=false
WebUI\Password_PBKDF2="@ByteArray(ARQ77eY1NUZaQsuDHbIMCA==:0WMRkYTUWVT9wVvdDtHAjU9b3b7uB8NR1Gur2hmQCvCDpm39Q+PsJRJPaCU51dFqjfk/HQUIxh6tGbB1lKFJlw==)"
WebUI\Port=8090
WebUI\Username=admin
QBCONF

# Start qBittorrent Web UI
qbittorrent-nox --webui-port=8090 --daemon 2>/dev/null || qbittorrent-nox --webui-port=8090 &
sleep 3
echo "[START] qBittorrent started on port 8090 (localhost auth bypassed)"

# Check aria2 is running
if ! pgrep aria2c > /dev/null; then
    echo "ERROR: aria2 failed to start"
    exit 1
fi

# Add local bin to PATH for gunicorn etc.
export PATH="$HOME/.local/bin:$PATH"

# Set download dir for WSL
export DOWNLOAD_DIR="/mnt/d/Projects/WZML-X/downloads/"

# Start the bot
echo "[START] Starting bot..."
python3.12 -m bot
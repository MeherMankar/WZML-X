<p align="center">
  <b>WZML-X — Telegram Leech Bot</b><br>
  <i>A powerful Telegram bot for leeching files from the web directly to Telegram. Supports torrents, direct links, Mega.nz, YouTube, JDownloader, SABnzbd, and more.</i>
</p>

---

## 🚀 Features

- **Multi-source Download**: Torrents (qBittorrent, Aria2c), direct links, Mega.nz, YouTube (yt-dlp), JDownloader, SABnzbd/Usenet
- **Leech to Telegram**: Upload downloaded files directly to any Telegram chat or channel
- **Advanced File Management**: Archive/extract (zip, rar, 7z), split/join, rename, FFmpeg processing
- **User & Sudo Controls**: Per-user settings, limits, and admin controls
- **Status & Queue System**: Real-time download/upload status, unlimited tasks, queue management
- **RSS Automation**: Auto-download and filter RSS feeds
- **Database Support**: MongoDB for persistent settings, tasks, and user data
- **Docker Ready**: Easy deployment with Docker & docker-compose
- **Extensive Configurability**: All features and limits configurable via config file or environment variables

---

## 📦 Deployment

### Requirements
- Linux (Ubuntu 22.04+ recommended) or WSL2 on Windows
- Python 3.12+
- MongoDB (local or [Atlas free tier](https://cloud.mongodb.com))
- aria2 (`sudo apt install aria2`)

### Setup

```bash
git clone https://github.com/your-repo/WZML-X
cd WZML-X
pip install -r requirements.txt
cp config_sample.py config.py
# Edit config.py with your values
bash start_local.sh
```

### Docker

```bash
docker compose up
```

---

## ⚙️ Configuration

Copy `config_sample.py` to `config.py` and fill in the values.

### Required

| Variable | Description |
|---|---|
| `BOT_TOKEN` | Telegram Bot Token from [@BotFather](https://t.me/BotFather) |
| `OWNER_ID` | Your Telegram User ID |
| `TELEGRAM_API` | API ID from [my.telegram.org](https://my.telegram.org) |
| `TELEGRAM_HASH` | API Hash from [my.telegram.org](https://my.telegram.org) |

### Common Optional

| Variable | Description |
|---|---|
| `DATABASE_URL` | MongoDB connection string |
| `LEECH_DUMP_CHAT` | Chat/channel ID where leeched files are sent |
| `AUTHORIZED_CHATS` | Space-separated list of allowed chat IDs |
| `SUDO_USERS` | Space-separated list of sudo user IDs |
| `LEECH_SPLIT_SIZE` | Max file split size in bytes (default: Telegram limit) |
| `DISABLE_TORRENTS` | Set `True` to disable qBittorrent (aria2 still works) |
| `BASE_URL_PORT` | Web server port for torrent file selection UI (default: 8080) |
| `USER_SESSION_STRING` | Pyrogram user session for premium upload speeds |
| `MEGA_EMAIL` / `MEGA_PASSWORD` | Mega.nz credentials |
| `JD_EMAIL` / `JD_PASS` | JDownloader credentials (enables `/jdleech`) |
| `USENET_SERVERS` | SABnzbd server config (enables `/nzbleech`) |
| `YT_DLP_OPTIONS` | Default yt-dlp options (JSON dict) |
| `TIMEZONE` | Timezone (default: `Asia/Kolkata`) |
| `SET_COMMANDS` | Auto-register bot commands on startup (default: `True`) |

---

## 🤖 Bot Commands

| Command | Alias | Description |
|---|---|---|
| `/leech` | `/l` | Leech from direct link, magnet, torrent, or Telegram file |
| `/qbleech` | `/ql` | Leech torrent using qBittorrent |
| `/ytdlleech` | `/yl` | Leech yt-dlp supported link (YouTube, etc.) |
| `/jdleech` | `/jl` | Leech using JDownloader *(requires JD config)* |
| `/nzbleech` | `/nl` | Leech NZB using SABnzbd *(requires Usenet config)* |
| `/status` | `/s` | Show all active tasks |
| `/cancel` | `/c` | Cancel a task by reply or GID |
| `/cancelall` | `/call` | Cancel all running tasks |
| `/forcestart` | `/fs` | Force start a queued task |
| `/select` | `/sel` | Select files from torrent/NZB |
| `/usetting` | `/us` | User personal settings |
| `/bsetting` | `/bs` | Bot admin settings |
| `/mediainfo` | `/mi` | Get media info of a file |
| `/speedtest` | `/stest` | Run a speed test |
| `/stats` | `/st` | Bot and system statistics |
| `/ping` | | Check bot response time |
| `/help` | `/h` | Full help with all arguments |
| `/rss` | | RSS feed management |
| `/imdb` | | Search IMDB for movies/shows |
| `/restart` | `/r` | Restart the bot (sudo only) |
| `/log` | | Get bot log file (sudo only) |

---

## 📋 Leech Arguments

All leech commands support these arguments:

```
/leech link -n new_name        rename the file
/leech link -z                 zip before upload
/leech link -z password        zip with password
/leech link -e                 extract archive
/leech link -up chat_id        upload to specific chat
/leech link -sp 2gb            split size override
/leech link -t tg_link         custom thumbnail
/leech link -doc               send as document
/leech link -med               send as media
/leech link -hl                hybrid leech (bot+user)
/leech link -b                 bulk from replied text
/leech link -i 5               multi-link (5 links)
/leech link -m folder_name     group into same folder
/leech link -s                 select torrent files
/leech link -sv                generate sample video
/leech link -ss                generate screenshots
/leech link -ca mp3            convert audio to mp3
/leech link -cv mp4            convert video to mp4
```

---

## 🏷️ Credits

- Base: [WZML-X](https://github.com/SilentDemonSD/WZML-X) by SilentDemonSD
- Modified by **Meher** — mirror features removed, leech-only

---

## 📄 License

[MIT License](LICENSE)

---

<p align="center">Made with ❤️ by Meher</p>

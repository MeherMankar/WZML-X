#!/bin/bash
set -e

# Heroku provides $PORT — export it for the bot's web server
export BASE_URL_PORT=${PORT:-8080}

# Activate virtualenv
if [ -f "/wzvenv/bin/activate" ]; then
  source /wzvenv/bin/activate
elif [ -f ".venv/bin/activate" ]; then
  source .venv/bin/activate
fi

export PATH="$HOME/.local/bin:$PATH"

# Run update.py only if UPSTREAM_REPO is set AND it's not a Heroku dyno restart loop
# update.py does a git reset which would wipe the working dir — skip on Heroku
# by leaving UPSTREAM_REPO unset in Heroku config vars
if [ -f "update.py" ] && [ -n "$UPSTREAM_REPO" ]; then
  /wzvenv/bin/python3 update.py
fi

# Start the bot
exec /wzvenv/bin/python3 -m bot

#!/bin/bash

APP=$(python "${0%/*}/extract-app.py" "$REPO_REL_DIR")
PR_PID_FILE="/tmp/tunnel-id-$PULL_NUM"

if [ -z "$APP" ]
  then
    echo "No app extracted from: $REPO_REL_DIR"
    echo "If this PR requires a tunnel to the Bastion it will need to be in a directory implying the app"
    exit 0
fi

echo "App extracted from $REPO_REL_DIR: $APP"
if [ "$1" = 'stop' ]
  then
    PID=$(cat "$PR_PID_FILE")
    echo "Closing ssh tunnel for PR $PULL_NUM with PID:$PID"
    kill "$PID"
    exit 0
fi

echo "Installing sl-cli"
pip3 install sl-cli==1.0+sl.1 -i https://sl:435cjHTdzvpg@nexus.sector.sh/repository/pypi/simple > /dev/null
export PATH="$HOME/.local/bin:$PATH"
echo "Finished installing sl-cli"

if [ "$1" = 'start' ]
  then
    if [ -z "$APP" ]
      then
        exit 0
    fi
    sl aws generate-profiles # Requires SL_AWS_ACCESS_KEY_ID and SL_AWS_SECRET_ACCESS_KEY
    sl aws tunnel $APP  &
    echo "$!" > "$PR_PID_FILE"
    echo "Tunnel opened for $APP"
fi

if [ "$1" = 'list' ]
  then
    ps aux | grep -i "sl aws tunnel"
fi
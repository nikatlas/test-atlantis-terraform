#!/bin/bash

echo "$DIR"
if [ "$1" = 'stop' ]
  then
    PID=$(cat "/tmp/tunnel-id-$PULL_NUM")
    echo "Closing ssh tunnel for PR $PULL_NUM with PID:$PID"
    kill "$PID"
    exit 0
fi

pip install sl-cli==1.0+sl.1 -i https://sl:435cjHTdzvpg@nexus.sector.sh/repository/pypi/pypi > /dev/null

if [ "$1" = 'start' ]
  then
    APP=$2
    if [ -z "$APP" ]
      then
        echo "No app provided. Usage: ./tunnel.sh start APP_NAME"
        exit 1
    fi

    sl aws tunnel $APP &>/dev/null &
    echo "$!" > "/tmp/tunnel-id-$PULL_NUM"
fi
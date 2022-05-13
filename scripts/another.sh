#!/bin/bash

if [ "$1" = 'stop' ]
  then
    echo "Closing all ssh tunnels running on this machine"
    TEMP_FILE="/tmp/temp-ps-aux"
    ps aux > $TEMP_FILE
    grep -i "sl aws tunnel" < $TEMP_FILE | awk '{ print $2 }' | xargs kill
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

    sl aws tunnel $APP > /dev/null &
fi
#!/bin/bash
set -e

MODE=${1:-'normal'}

if [[ "$MODE" == "debug" ]]
then
    echo "Starting salt-minion-minion"
    nohup salt-minion -l debug >/var/log/salt/minion 2>&1 &
else
    echo "Starting salt-minion-minion"
    salt-minion -d
fi

while true
do
    sleep 5
done
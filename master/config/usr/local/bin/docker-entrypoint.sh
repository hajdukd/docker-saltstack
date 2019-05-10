#!/bin/bash
set -e

MODE=${1:-'normal'}
STATE_APPLY=${2:-'dont-apply-on-start'}

#im lazy
if [[ "$MODE" == "apply-on-start" ]]
then
    STATE_APPLY="apply-on-start"
fi

if [[ "$MODE" == "debug" ]]
then
    echo "Starting salt-master"
    nohup salt-master -l debug >/var/log/salt/master 2>&1 &

    sleep 5

    echo "Starting salt-master-minion"
    nohup salt-minion -l debug >/var/log/salt/minion 2>&1 &
else
    echo "Starting salt-master"
    salt-master -d

    sleep 5

    echo "Starting salt-master-minion"
    salt-minion -d
fi

sleep 20

if [[ "$STATE_APPLY" == "apply-on-start" ]]
then
    salt '*' state.apply
fi

while true
do
    sleep 5
done
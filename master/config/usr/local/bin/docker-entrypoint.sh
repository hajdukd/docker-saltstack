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

if [[ "$STATE_APPLY" == "apply-on-start" ]]
then
    set +e
    echo "Waiting for master to become available to apply state. (10 sec)"
    sleep 10
    echo "salt '*' state.apply"
    salt '*' state.apply
    set -e
fi

while true
do
    sleep 5
done
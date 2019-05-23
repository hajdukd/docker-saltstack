#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
docker build --rm -t local/c7-systemd ${DIR}/../systemd_enabled_container/
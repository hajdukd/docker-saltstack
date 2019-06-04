#!/usr/bin/env bash

REPOSITORY=${1:-'salt-minion'}
TAG=${2:-'latest'}
AUTHOR=${3:-`whoami`}

# Create image
docker commit -a ${AUTHOR} salt-minion ${REPOSITORY}:${TAG}

# Clean up
docker rmi $(docker images -f "dangling=true" -q)
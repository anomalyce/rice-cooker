#!/usr/bin/env bash

docker build \
    --no-cache \
    --build-arg DOCKER_UID=$(id -u) \
    --build-arg DOCKER_GID=$(id -g) \
    -t globalnode \
    -f ./npm ../


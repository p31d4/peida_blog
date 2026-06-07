#!/bin/bash

if [ "$#" -ne 1  ] || ! [ -d $1  ]
then
    echo "usage: $0 <git_repos DIR>" >&2
    exit 1
fi

# XWayland/X11
run_x_docker() {
    docker run --rm --privileged --init -it \
        --env "TERM=xterm-256color" --net=host \
        -v "$XAUTHORITY:/root/.XAuthority:rw" \
        -e XAUTHORITY=/root/.XAuthority \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v "$1":${HOME}/git_repos \
        p31d4/dx_devenv:0.1
}

run_x_docker $1

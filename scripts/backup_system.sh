#! /usr/bin/env bash

cd /
sudo tar -cvpzf backup.tar.gz \
    --one-file-system \
    --exclude=/backup.tar.gz \
    --exclude=/proc \
    --exclude=/tmp \
    --exclude=/mnt \
    --exclude=/dev \
    --exclude=/sys \
    --exclude=/run \
    --exclude=/media \
    --exclude=/var/log \
    --exclude=/var/cache/apt/archives \
    --exclude=/usr/src/linux-headers* \
    --exclude=/home/*/.gvfs \
    --exclude=/home/*/.cache \
    --exclude=/home/*/.local/share/Trash /

#! /usr/bin/env bash

function install_font() {
    cp -r $@ ~/.local/share/fonts
    fc-cache -vf
}

install_font $@

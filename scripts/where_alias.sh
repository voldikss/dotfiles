#! /usr/bin/env bash

function where_alias() {
    rg --pretty "$1" ~/.oh-my-zsh ~/.zshrc ~/.aliases | less
}

where_alias $@

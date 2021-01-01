# vim:ft=sh
#!/bin/zsh
# Author: VOLDIKSS
# Date  : 2019-03-22


#=============================================================================
# Functions
#=============================================================================
backup_sys() {
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
}

deploy_blog() {
    echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
    hugo -t even

    cd public
    git add .

    msg="rebuilding site `date`"
    if [ $# -eq 1 ]; then
        msg="$1"
    fi

    git commit -m "$msg"
    git push origin master

    cd ..
    git add .
    git commit -m "$msg"
    git push origin master
}

release_coc_extension() {
    version=$(json version < package.json)
    name=$(json name < package.json)
    echo "$name/$version"
    git commit -a -m "v$version"
    git tag -a "$version" -m "v$version"
    npm publish
    git push --tags
    git push
}

vim_starttime() {
    if [ -f "vim_startup.log" ]; then
        rm ./vim_startup.log
    fi
    nvim --startuptime ./vim_startup.log && awk -F'[ /]' '/\.vim\/plugged/ {print $3,$12}' vim_startup.log | awk '{plug[$2]++; time[$2]+=$1} END {for (i in plug) {printf "%30s %20.3f ms\n", i, time[i] | "sort -k2nr"}}'
}

where_alias() {
    grep -RHi "alias" /etc ~ | grep $1 | less
}


#=============================================================================
# antigen
#=============================================================================
source $HOME/.antigen.zsh

antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle colorize
# antigen bundle git # it has too many alias...
antigen bundle git-extras
antigen bundle git-flow
antigen bundle github
antigen bundle gradle
antigen bundle mercurial
antigen bundle pip
antigen bundle pyenv
antigen bundle pylint
antigen bundle python
antigen bundle repo

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle momo-lab/zsh-abbrev-alias
antigen bundle hlissner/zsh-autopair

antigen bundle skywind3000/z.lua
ZLUA_EXEC=$(which luajit)
export _ZL_MATCH_MODE=1
export _ZL_ADD_ONCE=1
export _ZL_CMD=j
export _ZL_HYPHEN=1
alias jc='j -c'      # 严格匹配当前路径的子路径
alias jz='j -i'      # 使用交互式选择模式
alias jf='j -I'      # 使用 fzf 对多个结果进行选择
alias jb='j -b'      # 快速回到父目录

antigen apply


#=============================================================================
# oh-my-zsh
#=============================================================================
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gnzh"
source $ZSH/oh-my-zsh.sh
# source $HOME/.af-magic.zsh-theme    # theme
source $HOME/.alias


#=============================================================================
# misc
#=============================================================================
export VISUAL=/usr/bin/nvim
export EDITOR=/usr/bin/nvim
# export MANPAGER="nvim '+set ft=man' -"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# You may need to manually set your language environment
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
export LC_CTYPE=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# man 着色
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# fzf integrated with rg
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#=============================================================================
# path
#=============================================================================
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# GoLang
export GOROOT=/usr/lib/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export GOPATH="$HOME/go"
# Cargo
export PATH="$HOME/.cargo/bin:$PATH"
# It would slow down zsh startup, disable it for the moment
# source /usr/share/nvm/init-nvm.sh

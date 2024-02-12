alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias md='mkdir -p'
alias rd=rmdir
alias rmrf='rm -rf'
alias -- -='cd -'

# ls
alias ll='ls -laFh'
alias la='ls -laFh'
alias lh='ls -lh'
alias lR='ls -lR'
alias l='ls -lh'

alias k='kubectl'
alias d=docker

# system
alias pgrep='pgrep -a'

# less
alias le=less

# bat
# 比较常用，所以确保只有安装了 bat 才做 alias，否则不做 alias，要保证总是有命令是可用的
if [[ ! $(command -v bat &> /dev/null) ]]; then
    alias cat=bat
fi

# vim
if [[ ! $(command -v nvim &> /dev/null) ]]; then
    alias vim=nvim
    alias vi=nvim
    alias v=nvim
fi

# python
if [[ $(uname -r) =~ "arch" ]]; then
    alias python=python3
fi
alias pip_upgrade_all_packages="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H pip install -U"
alias pip_pkglist_backup='pip list > $HOME/dotfiles/misc/pip/pip_list.txt'
alias pip_pkglist_restore='for x in $(cat $HOME/dotfiles/misc/pip/pip_list.txt); do pip install $x; done'

# git
alias g='git'
alias ga='git add'
alias gaa='git add .'
alias gb='git branch'
alias gc='git commit -v'
alias gcn='git commit -vn'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-verify'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gcl='git clone --depth 1'
alias gd='git diff'
alias gD='git branch -D'
alias gf='git fetch'
alias gi='git init'
alias gl='git log'
alias gr='git reset --hard HEAD'
alias gp='git push'
alias gpf='git push -f'
alias gri='git rebase -i'
alias grc='git rebase --continue'
alias gs='git status'
alias gst='git stash'
alias gsp='git stash pop'
alias gacp='git add . && git commit -m "update" -n; git push'
alias gac='git add . && git commit -m "update" -n'
alias gpl='git pull'
alias gps='git push'

# rm 进 trash
if [[ ! $(command -v trash &> /dev/null) ]]; then
    alias rm='trash -r'
    alias clear_trash='sudo rm -r ~/.local/share/Trash/files ~/.local/share/Trash/info'
fi

# fzf
alias fzfvim='vim $(fzf)'
if [[ ! $(command -v fzf &> /dev/null) ]]; then
    alias fzf="fzf --preview 'bat --style=numbers --color=always {} | head -500'"
fi

# prettyping
# alias ping='prettyping'

# htop
alias top=htop

# du
# alias du='ncdu --color dark -rr -x --exclude .git --exclude node_modules'
alias sizeof='/usr/bin/du -sh'

# nnn
alias nnn='nnn -d'

# where proxy
alias pc=proxychains

# npm registry
alias npmmirror='npm config set registry https://registry.npmmirror.com'
alias npmorigin='npm config set registry https://registry.npmjs.org'
alias npmcheckupdates='ncu -u && npm i' # need `npm install -g npm-check-updates`
alias npmdisablepkglock='npm config set package-lock false'

#
alias pi='pnpm i'
alias pa='pnpm add'
alias pb='pnpm build'

# pacman && yay
alias p='sudo pacman'
alias S='sudo pacman -S'
alias Ss='sudo pacman -Ss'
alias Rns='sudo pacman -Rns'
alias Qi='sudo pacman -Qi'
alias Qo='sudo pacman -Qo' # 该命令属于哪个软件包
alias Qs='sudo pacman -Qs'
alias yS='yay -S'
alias ySs='yay -Ss'

# dos2unix
alias dos2unix_all='find . -type f -print0 | xargs -0 dos2unix'

# cgdb nvim
# might need `echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope`
alias cgdb_nvim="gdb -p $(ps auxx | grep '[.]/build/bin/nvim' | awk '{print $2}')"

# pacman package list backup and restore
alias pacman_pkglist_backup='comm -23 <(pacman -Qeq|sort) <(pacman -Qmq|sort) > $HOME/dotfiles/misc/pacman/pkglist'
alias pacman_pkglist_restore='for x in $(cat $HOME/dotfiles/misc/pacman/pkglist); do sudo pacman -S $x --noconfirm; done'

# screen record
alias screenrecord='ffmpeg -f x11grab -video_size 1920x1080 -framerate 25 -i $DISPLAY -f alsa -i default -c:v libx264 -preset ultrafast -c:a aac'

# reset
alias re=reset

# filetype
alias gz='tar -xzvf'
alias tgz='tar -xzvf'
alias zip='unzip'
alias bz2='tar -xjvf'
alias untar='tar -zxvf'

# floaterm
alias f=floaterm

# verbose
alias mv='mv -v'
alias cp='cp -v'
alias mkdir='mkdir -v'

# misc
alias c=clear
alias path='echo -e ${PATH//:/\\n}'
alias space='df -P -kHl'

# scripts
DOTFILES=$HOME/dotfiles
if [[ -d $DOTFILES ]]; then
    # usage: alias_dotfiles <dir>
    function alias_dotfiles() {
    for f in $(ls $1)
    do
        if [ -d $1/$f ]
        then
        alias_dotfiles $1/$f
        else
        IN=$f
        if [[ $(readlink /proc/$$/exe) == *zsh* ]]
        then
            IFS='.' read -rA ADDR <<< "$IN"
            alias ${ADDR[1]}=$1/$f
        else
            IFS='.' read -ra ADDR <<< "$IN"
            alias ${ADDR[0]}=$1/$f
        fi
        fi
    done
    }
    alias_dotfiles $DOTFILES/scripts
fi

# cpp_dump_memory_layout
# usage: cpp_dump_memory_layout <cppfile>
alias cpp_dump_memory_layout='clang++ -cc1 -emit-llvm -fdump-record-layouts -fdump-vtable-layouts'

alias grep='grep --ignore-case --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

# k8s
alias k9sprod='cp ~/.kube/config.prod ~/.kube/config && k9s'
alias k9sdev='cp ~/.kube/config.dev ~/.kube/config && k9s'
alias k9sshared='cp ~/.kube/config.shared ~/.kube/config && k9s'
alias k9sselfhosted='cp ~/.kube/config.selfhosted ~/.kube/config && k9s'
alias k9sops='cp ~/.kube/config.devops ~/.kube/config && k9s'
alias k9sminikube='cp ~/.kube/config.minikube ~/.kube/config && k9s'
alias k9ssit='cp ~/.kube/config.sit ~/.kube/config && k9s'
alias k9sarch='cp ~/.kube/config.arch ~/.kube/config && k9s'
alias k9sk3s='cp ~/.kube/config.k3s ~/.kube/config && k9s'

minikube_setup='minikube start --cpus 8 --memory 8192 --nodes 1 --kubernetes-version 1.23.15 --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --profile minikube'

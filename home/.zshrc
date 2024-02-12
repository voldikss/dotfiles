# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk


#############################################
# Zinit Plugins
#############################################
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice lucid wait="0"
zinit light zsh-users/zsh-completions

zinit ice lucid wait="0"
zinit light momo-lab/zsh-abbrev-alias

zinit ice lucid wait="0"
zinit light hlissner/zsh-autopair                    # Autopair

zinit ice lucid wait="0"
zinit light olivierverdier/zsh-git-prompt            # git-prompt

zinit ice lucid wait="0"
zinit light skywind3000/z.lua

zinit snippet OMZP::golang
zinit snippet OMZP::command-not-found
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/git-extras/git-extras.plugin.zsh
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit snippet OMZ::plugins/common-aliases/common-aliases.plugin.zsh
zinit snippet OMZ::plugins/pip/pip.plugin.zsh

zinit ice depth=1
zinit light romkatv/powerlevel10k
############################################



############################################
# Plugins Configuration
############################################
ZLUA_EXEC=$(which luajit)
export _ZL_MATCH_MODE=1
export _ZL_ADD_ONCE=1
export _ZL_CMD=j
export _ZL_HYPHEN=1
alias jc='j -c'      # 严格匹配当前路径的子路径
alias jz='j -i'      # 使用交互式选择模式
alias jf='j -I'      # 使用 fzf 对多个结果进行选择
# alias jb='j -b'      # 快速回到父目录

############################################
# Options
############################################
setopt interactivecomments


############################################
# My Configuration
############################################
for file in ~/.config/zsh/{functions,env,aliases,extra}.zsh; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


############################################
# Completions
############################################
autoload -Uz compinit && compinit
if [ -d "$HOME/.config/zsh/completions" ];then
    source $HOME/.config/zsh/completions/helmfile.zsh
    # fpath+=($HOME/.config/zsh/completions) # XXX: not work?
fi


#=============================================================================
# Environment Variables
#=============================================================================
export VISUAL=/usr/local/bin/nvim
# export EDITOR=/usr/local/bin/nvim
# export MANPAGER="nvim '+set ft=man' -"
export REACT_EDITOR=code

# Uncomment the following line to enable command auto-correction.
export ENABLE_CORRECTION="true"

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

# less
export LESS='RX'

# fzf integration
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


############################################
# Path Environment Variables
############################################
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# GoLang
export GOROOT=/usr/lib/go
export GOPATH="$HOME/go"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export GO111MODULE=on
export GOPROXY=https://goproxy.cn
# Cargo
export PATH="$HOME/.cargo/bin:$PATH"
# It would slow down zsh startup, disable it for the moment
# source /usr/share/nvm/init-nvm.sh
export PATH=/opt/openresty/bin:$PATH

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  --no-use
alias node='unalias node ; unalias npm ; nvm use default ; node $@'
alias npm='unalias node ; unalias npm ; nvm use default ; npm $@'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Zinit & nvm's slowness
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
export NPM_BIN_PATH="$HOME/.nvm/versions/node/v17.4.0/bin/"
export PATH="$NPM_BIN_PATH:$PATH"


export MAKEFLAGS=--no-print-directory

# kitty
# NOTE: 会导致 ssl -L 不工作
# [[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

#compdef k3s
_cli_zsh_autocomplete() {

	local -a opts
	local cur
	cur=${words[-1]}
	if [[ "$cur" == "-"* ]]; then
	opts=("${(@f)$(_CLI_ZSH_AUTOCOMPLETE_HACK=1 ${words[@]:0:#words[@]-1} ${cur} --generate-bash-completion)}")
	else
	opts=("${(@f)$(_CLI_ZSH_AUTOCOMPLETE_HACK=1 ${words[@]:0:#words[@]-1} --generate-bash-completion)}")
	fi

	if [[ "${opts[1]}" != "" ]]; then
	_describe 'values' opts
	else
	_files
	fi

	return
}

compdef _cli_zsh_autocomplete k3s

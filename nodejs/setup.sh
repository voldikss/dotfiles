__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed nodejs
ensure_installed yarn
ensure_installed npm
ensure_installed nvm

NPMRC_PATH=$HOME/.npmrc
if ! test -e "$NPMRC_PATH" &> /dev/null
then
    cp "$__dirname/.npmrc" $NPMRC_PATH
fi


# upstream
# - https://github.com/cheat/cheatsheets
# - https://github.com/skywind3000/awesome-cheatsheets

__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

if ! command -v cheat &> /dev/null
then
    proxychains yay -S cheat --noconfirm
fi

CONFIG_DIR="$HOME/.config/cheat"

if ! test -d "$CONFIG_DIR"
then
    rm -rf "$CONFIG_DIR"
fi

mkdir -p "$CONFIG_DIR"

ln -sf "$__dirname/conf.yml" "$CONFIG_DIR/conf.yml"

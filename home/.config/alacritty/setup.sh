__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed alacritty

CONFIG_DIR="$HOME/.config/alacritty"
ensure_folder "$CONFIG_DIR"

ln -sf "$__dirname/alacritty.yml" "$CONFIG_DIR/alacritty.yml"


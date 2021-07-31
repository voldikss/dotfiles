__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed bat

CONFIG_DIR="$HOME/.config/bat"
ensure_folder "$CONFIG_DIR"

ln -sf "$__dirname/config" "$CONFIG_DIR/config"


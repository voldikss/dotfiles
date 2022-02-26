__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed terminator

CONFIG_DIR="$HOME/.config/rofi"
ensure_folder "$CONFIG_DIR"

ln -sf "$__dirname" "$CONFIG_DIR"


__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed fontconfig

FNOT_CONFIG_DIR="$HOME/.config/fontconfig"

ensure_folder "$FNOT_CONFIG_DIR"

ln -sf "$__dirname/fonts.conf" "$FNOT_CONFIG_DIR/fonts.conf"

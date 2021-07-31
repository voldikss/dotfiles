__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed cargo

CONFIG_DIR="$HOME/.cargo"
ensure_folder "$CONFIG_DIR"

ln -sf "$__dirname/config" "$CONFIG_DIR/config"


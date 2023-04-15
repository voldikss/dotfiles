__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed python
ensure_installed python-pip

CONFIG_DIR="$HOME/.config/pip"
ensure_folder "$CONFIG_DIR"

ln -sf "$__dirname/pip.conf" "$CONFIG_DIR/pip.conf"

__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed ranger

CONFIG_DIR="$HOME/.config/ranger"
ensure_folder "$CONFIG_DIR"

# TODO
ln -sf "$__dirname/config" "$CONFIG_DIR"

ensure_installed python
pip install ueberzug

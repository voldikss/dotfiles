__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed git

GIT_CONFIG_DIR="$HOME/.config/git"

ensure_folder "$GIT_CONFIG_DIR"

ln -sf "$__dirname/config" "$GIT_CONFIG_DIR/config"

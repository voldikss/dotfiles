__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed fcitx5-im
ensure_installed librime
ensure_installed fcitx5-rime

CONFIG_DIR="$HOME/.local/share/fcitx5"
ensure_folder $CONFIG_DIR

RIME_CONFIG_DIR="$CONFIG_DIR/rime"
ensure_folder $RIME_CONFIG_DIR
for custom_config in $__dirname/rime/*.custom.yaml # NOTE: no double quotes(") !!!
do
    filename=$(basename "$custom_config")
    ln -sf "$custom_config" "$RIME_CONFIG_DIR/$filename"
done

THEMES_DIR="$CONFIG_DIR/themes"
ensure_folder "$THEMES_DIR"
for theme in $__dirname/themes/* # NOTE: no double quotes(") !!!
do
    filename=$(basename "$theme")
    ln -sf "$theme" "$THEMES_DIR"
done

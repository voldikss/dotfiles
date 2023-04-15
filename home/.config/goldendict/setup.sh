__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed goldendict

CONFIG_DIR="$HOME/.goldendict"

ensure_folder "$CONFIG_DIR"

ln -sf "$__dirname/config" "$CONFIG_DIR/config"

# install ecdict
ECDICT_DOWNLOAD_URL="https://github.com/skywind3000/ECDICT/releases/download/1.0.28/ecdict-mdx-style-28.zip"
ECDICT_DOWNLOAD_PATH="$(mktemp -d)/ecdict.zip"
ECDICT_STORAGE_PATH=~/.local/share/goldendict/content
mkdir -p $ECDICT_STORAGE_PATH
proxychains curl -L $ECDICT_DOWNLOAD_URL -o $ECDICT_DOWNLOAD_PATH
unzip $ECDICT_DOWNLOAD_PATH -d $ECDICT_STORAGE_PATH

# Install google-translate-for-goldendict
# google translate for goldendict https://github.com/xinebf/google-translate-for-goldendict/

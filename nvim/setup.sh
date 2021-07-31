__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed neovim

CONFIG_DIR="$HOME/.config/nvim"

if ! test -d "$CONFIG_DIR"
then
    rm -rf "$CONFIG_DIR"
fi

# mkdir -p "$CONFIG_DIR"

ln -sf "$__dirname" "$CONFIG_DIR"


# python related
ensure_python
if command -v pip3 &> /dev/null
then
    PIP_CMD=pip3
else
    PIP_CMD=pip
fi

pip_pkgs=(
    pynvim
    neovim-remote
    yapf
    flake8
    autopep8
    python-language-server
    pylint
    black
)
pip_pkgs_installed=$($PIP_CMD list)
for pkg in ${pip_pkgs[*]}
do
    if ! echo $pip_pkgs_installed | grep $pkg &> /dev/null
    then
        $PIP_CMD install $pkg
    fi
done

# nodejs related
ensure_nodejs
yarn_pkgs=(
    neovim
    bash-language-server
    write-good
    markdownlint-cli
)
yarn_pkgs_installed=$(yarn global list)
for pkg in ${yarn_pkgs[*]}
do
    if ! echo $yarn_pkgs_installed | grep $pkg &> /dev/null
    then
        yarn global add $pkg
    fi
done

# ctags & gtags & rg
ensure_installed ripgrep
ensure_installed ctags
if ! command -v gtags &> /dev/null
then
    yay -S global --noconfirm
fi


# proxychains nvim +PI +qa

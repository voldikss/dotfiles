__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed zsh

# Install ohmyzsh
if ! test -d /home/dyzh/.oh-my-zsh &> /dev/null
then
    sh -c $(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)
fi

ln -sf "$__dirname/../home/.aliases" $HOME
ln -sf "$__dirname/../home/.functions" $HOME
ln -sf "$__dirname/../home/.zshrc" $HOME
ln -sf "$__dirname/../home/.antigen.zsh" $HOME
ln -sf "$__dirname/../home/.af-magic.zsh-theme" $HOME
source $HOME/.zshrc

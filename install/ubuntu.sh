#! /bin/bash

function copy_files(){
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo cp ../sources/ubuntu/sources.list /etc/apt/sources.list

    sudo cp -rf ../pip/.pip/ $HOME
    sudo cp -f ../inputrc/.inputrc $HOME
    sudo cp -f ../git/.gitconfig $HOME
    sudo cp -f ../shadowsocks/.shadowsocks.json $HOME
}

function oh_my_zsh_install(){
    # zsh
    sudo apt install zsh -y
    # oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sudo cp -f ../zsh/.af-magic.zsh-theme $HOME/
    sudo cp -f ../zsh/.myzshrc $HOME
    source ~/.zshrc
}

function vim_install(){
    sudo apt remove vim -y
    sudo apt remove vim-gtk -y

    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install neovim -y

    sudo pip3 install pynvim
    sudo pip3 install yapf
    sudo pip3 install flake8
    sudo pip3 install autopep8

    # zsh complete
    if command -v zmodload; then
        zmodload zsh/zpty
    fi

    sudo cp -f ../vim/.vimrc $HOME
    sudo cp -rf ../vim/.vim $HOME
    sudo cp -rf ../vim/.config/ $HOME

    sudo mkdir -p $HOME/.vim/plugged

    nvim -c ':PlugInstall --sync | :qa!'
    nvim -c ':UpdateRemotePlugin  | :qa!'
    nvim -c ':CocInstall coc-dictionary coc-tag coc-word coc-emoji coc-omni coc-pyls  | :qa!'
}

function python_install(){
    sudo apt install python-dev -y
    sudo apt install python3-dev -y
    sudo apt install python-pip -y
    sudo apt install python3-pip -y
    sudo apt install idle3 -y

    sudo -H pip3 install requests
    sudo -H pip3 install numpy
    sudo -H pip3 install scipy
    sudo -H pip3 install matplotlib
}

function tmux_install(){
    sudo apt install tmux -y
    sudo cp -f ../tmux/.tmux.conf $HOME
}

function nodejs_install(){
    sudo apt install nodejs -y
    sudo apt install npm -y
}

function ctags_install(){
    git clone https://github.com/universal-ctags/ctags.git --depth=1
    sudo apt install autoconf -y
    sudo apt install pkg-config -y
    cd ctags
    ./autogen.sh
    ./configure
    sudo make
    sudo make install
    cd -
    rm -r ctags
}

function nerdfont_install(){
    sudo mkdir -p ~/.local/share/fonts
    sudo cp ../fonts/* ~/.local/share/fonts
}

function others_install(){
    sudo apt install gnome-tweak-tool -y
    sudo wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
    sudo apt-get update
    sudo apt install google-chrome-stable -y
}

function confirm_install(){
    while true; do
        echo "Install $1?"
        read ans
        case $ans in
            [Yy]* ) $2; break;;
            [Nn]* ) break;;
            * ) echo "Please choose yes or no [y/n]:";;
        esac
    done
}

function ubuntu_install()
{
    # Initial
    copy_files
    sudo apt update -y
    sudo apt upgrade -y

    # Install
    sudo apt install openssh-client git wget curl unrar unzip tree -y
    python_install
    vim_install

    # Confirm needed install
    confirm_install tmux tmux_install
    confirm_install nodejs nodejs_install
    confirm_install ctags ctags_install
    confirm_install nerdfont nerdfont_install
    echo "Others include: gnome-tweak | chrome"
    confirm_install others others_install

    oh_my_zsh_install
}

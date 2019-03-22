#! /bin/bash

function copy_files(){
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo cp ../sources/ubuntu/sources.list /etc/apt/sources.list

    sudo cp -rf ../pip/.pip/ $HOME
    sudo cp -f ../inputrc/.inputrc $HOME
    sudo cp -f ../git/.gitconfig $HOME
    sudo cp -f ../shadowsocks/.shadowsocks.json $HOME
}

function common_install(){
    # common tools
    sudo apt install openssh-client git wget curl unrar unzip tree -y
    # trash
    sudo apt install trash-cli -y
    # bat
    curl -o bat.deb https://github.com/sharkdp/bat/releases/download/v0.10.0/bat_0.10.0_amd64.deb
    sudo dpkg -i bat.deb
    # catimg
    sudo apt install catimg -y
    # fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    # prettyping
    git clone https://github.com/denilsonsa/prettyping.git
    sudo cp ./prettyping/prettyping /usr/bin/
    # htop
    sudo apt install htop -y
    # ranger
    sudo apt install ranger -y
    # ncdu
    curl -o ncdu.tar https://dev.yorhel.nl/download/ncdu-1.14.tar.gz
    tar -xf ncdu.tar
    cd ncdu-1.14
    ./configure --prefix=/usr
    sudo make
    sudo make install
    cd ..
    # nnn
    git clone https://github.com/jarun/nnn
    cd nnn
    sudo apt install pkg-config libncursesw5-dev libreadline6-dev
    make
    sudo make install
    cd ..
}

function oh_my_zsh_install(){
    # zsh
    sudo apt install zsh -y
    # oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sudo cp -f ../zsh/af-magic.zsh-theme $HOME/.oh-my-zsh/themes
    sudo cp -f ../zsh/.zshrc $HOME
    ### Plugins
    # zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    # zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    # fasd
    sudo add-apt-repository ppa:aacebedo/fasd -y
    sudo apt update
    sudo apt install fasd -y
    # extract
    sudo apt install extract -y
    source ~/.zshrc
}

function vim_install(){
    sudo apt remove vim -y
    sudo apt remove vim-gtk -y

    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install neovim -y

    sudo -H pip3 install pynvim
    sudo -H pip3 install yapf
    sudo -H pip3 install flake8
    sudo -H pip3 install autopep8

    sudo npm -g install js-beautify
    sudo npm -g install eslint
    sudo npm -g install html-beautify
    sudo npm -g install css-beautify
    sudo npm -g install remark-cli

    # for keysound
    sudo apt install python3-sdl2 -y

    # zsh complete
    if command -v zmodload; then
        zmodload zsh/zpty
    fi

    sudo cp -f ../vim/.vimrc $HOME
    sudo cp -rf ../vim/.vim $HOME
    sudo cp -rf ../vim/.config/ $HOME

    sudo mkdir -p $HOME/.vim/plugged
    sudo chmod -R 777 $HOME/.vim

    nvim -c ':PlugInstall --sync | :qa!'
    nvim -c ':UpdateRemotePlugin  | :qa!'
    nvim -c ':CocInstall coc-dictionary coc-tag coc-word coc-emoji coc-omni coc-pyls coc-tsserver coc-wxml coc-css coc-json coc-html'
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
    # thefuck
    sudo -H pip3 install thefuck
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
    sudo apt update
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

    common_install
    python_install
    vim_install

    # Confirm needed install
    confirm_install tmux tmux_install
    confirm_install nodejs nodejs_install
    confirm_install ctags ctags_install
    confirm_install nerdfont nerdfont_install
    echo "Others include: gnome-tweak | chrome"
    confirm_install others others_install

    # oh_my_zsh
    oh_my_zsh_install
}

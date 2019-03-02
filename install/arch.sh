#! /bin/bash

function copy_files(){
    sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    sudo cp ../sources/arch/mirrorlist /etc/pacman.d/mirrorlist
    sudo cp /etc/pacman.conf /etc/pacman.conf.bak
    sudo cp ../sources/arch/pacman.conf /etc/pacman.conf

    sudo cp -rf ../pip/.pip/ $HOME
    sudo cp -f ../inputrc/.inputrc $HOME
    sudo cp -f ../git/.gitconfig $HOME
    sudo cp -f ../xinitrc/.xinitrc $HOME
    sudo cp -f ../xprofile/.xprofile $HOME
}

function fonts_install(){
    # system cn font
    sudo pacman -S adobe-source-han-sans-cn-fonts  --noconfirm
    # emoji font
    sudo pacman -S noto-fonts-emoji --noconfirm
    # Monaco font
    sudo cp ../fonts/Monaco\ for\ Powerline.ttf /usr/share/fonts/TTF/
    # nerd fonts
    sudo mkdir -p /usr/share/fonts/NerdFonts/
    sudo cp ../fonts/Droid Sans Mono Nerd Font Complete Mono.otf /usr/share/fonts/NerdFonts/
    sudo cp ../fonts/Monaco Nerd Font Complete Mono.otf /usr/share/fonts/NerdFonts/
    sudo fc-cache -fv
}

function oh_my_zsh_install(){
    # zsh
    sudo pacman -S zsh --noconfirm
    # oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sudo cp -f ../zsh/.af-magic.zsh-theme $HOME/
    sudo cp -f ../zsh/.myzshrc $HOME
    source ~/.zshrc
}

function python_install(){
    sudo pacman -S python --noconfirm --needed
    sudo pacman -S python-pip --noconfirm --needed
    # idle
    sudo pacman -S tk --noconfirm --needed

    sudo -H pip install requests
    sudo -H pip install numpy
    sudo -H pip install scipy
    sudo -H pip install matplotlib
}

function vim_install(){
    sudo pacman -R vim --noconfirm
    sudo pacman -S neovim --noconfirm --needed

    sudo -H pip install pynvim
    sudo -H pip install yapf
    sudo -H pip install flake8
    sudo -H pip install autopep8
    sudo -H pip install jedi

    sudo npm -g install js-beautify

    # zsh complete
    if command -v zmodload; then
        zmodload zsh/zpty
    fi

    sudo cp -f ../vim/.vimrc $HOME
    sudo cp -rf ../vim/.vim $HOME
    sudo cp -rf ../vim/.config/ $HOME

    nvim -c ':PlugInstall --sync | :qa!'
    nvim -c ':UpdateRemotePlugin  | :qa!'
    nvim -c ':CocInstall coc-dictionary coc-tag coc-word coc-emoji coc-omni coc-pyls coc-tsserver coc-wxml coc-css coc-json coc-html'
}

function tmux_install(){
    sudo pacman -S tmux --noconfirm --needed
    sudo cp -f ../tmux/.tmux.conf $HOME
}

function nodejs_install(){
    sudo pacman -S nodejs --noconfirm --needed
    sudo pacman -S npm --noconfirm --needed
}

function ctags_install(){
    git clone https://github.com/universal-ctags/ctags.git --depth=1
    cd ctags
    ./autogen.sh
    ./configure
    sudo make
    sudo make install
    cd ..
}

function others_install(){
    sudo pacman -S chromium --noconfirm --needed
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

function arch_install()
{
    # Initial
    copy_files
    sudo pacman -Syy --noconfirm

    # Install
    sudo pacman -S openssh git wget curl unrar unzip tree --noconfirm --needed
    python_install
    fonts_install
    vim_install

    # Confirm needed install
    confirm_install tmux tmux_install
    confirm_install nodejs nodejs_install
    confirm_install ctags ctags_install
    echo "Others include: |chromium|"
    confirm_install others others_install

    # oh-my-zsh should be installed finally
    oh_my_zsh_install
}

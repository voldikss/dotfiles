#! /bin/bash

# netease cloud music
# sougou pinyin

# Reset
Reset='\033[0m'           # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

cecho() {
    echo -e "${Yellow}$@"${Reset};
}

cfence(){
    echo -e "${Green}$@"${Reset};
}
crun() {
    echo -e "${Purple}\$${Reset} ${Cyan}$@"${Reset} ; "$@" ;
}

function uninstall() {
    crun sudo apt remove libreoffice libreoffice-common firefox -y
}

function initialize(){
    cecho "Initializing..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    crun sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    crun sudo cp ../sources/ubuntu/sources.list /etc/apt/sources.list

    crun sudo cp -rf ../pip/.pip/ $HOME
    crun sudo cp -f ../idlerc $HOME/.idlerc
    crun sudo cp -f ../inputrc/.inputrc $HOME
    crun sudo cp -f ../git/.gitconfig $HOME
    crun sudo cp -f ../shadowsocks/.shadowsocks.json $HOME
    crun sudo apt update -y
    crun sudo apt upgrade -y
}

function common_install(){
    cecho "Installing common used tools..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    # common tools
    crun sudo apt install openssh-client git wget curl unrar unzip tree xclip make cmake -y
    # trash
    crun sudo apt install trash-cli -y
    # bat
    crun wget -O bat.deb https://github.com/sharkdp/bat/releases/download/v0.10.0/bat_0.10.0_amd64.deb
    crun sudo dpkg -i bat.deb
    crun rm bat.deb
    # catimg
    crun sudo apt install catimg -y
    # ripgrep
    crun wget -O rg.deb https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
    crun sudo dpkg -i rg.deb
    crun rm rg.deb
    # fzf
    crun git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    crun ~/.fzf/install --all --64
    # prettyping
    crun git clone https://github.com/denilsonsa/prettyping.git --depth 1
    crun sudo cp ./prettyping/prettyping /usr/bin/
    crun rm -rf prettyping
    # htop
    crun sudo apt install htop -y
    # ranger
    crun sudo apt install ranger -y
    # ncdu
    crun curl -LO https://dev.yorhel.nl/download/ncdu-1.14.tar.gz
    crun tar -xf ncdu-1.14.tar.gz
    crun cd ncdu-1.14
    crun sudo apt install libncurses5-dev libncursesw5-dev -y
    crun ./configure --prefix=/usr
    crun sudo make
    crun sudo make install
    crun cd ..
    crun rm -rf ncdu*
    # nnn
    crun git clone https://github.com/jarun/nnn --depth 1
    crun cd nnn
    crun sudo apt install pkg-config libncursesw5-dev libreadline6-dev -y
    crun make
    crun sudo make install
    crun cd ..
    crun rm -rf nnn
    # zathura
    crun sudo apt install zathura -y
    # v2ray
    crun curl -LO -s https://install.direct/go.sh
    crun sudo bash go.sh
}

function oh_my_zsh_install(){
    cecho "Installing Oh-my-zsh and others..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    # zsh
    crun sudo apt install zsh -y
    # oh-my-zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        crun sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        crun sudo cp -f ../zsh/af-magic.zsh-theme $HOME/.oh-my-zsh/themes
        crun sudo cp -f ../zsh/.zshrc $HOME
    else
        cecho "NOTE: oh-my-zsh has already been installed and won't be installed here"
    fi
    ### Plugins
    # zsh-autosuggestions
    crun git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    # zsh-syntax-highlighting
    crun git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    # fasd
    crun git clone https://github.com/clvv/fasd.git --depth 1
    crun cd fasd
    crun sudo make install
    crun cd ..
    # extract
    crun sudo apt install extract -y
    crun source ~/.zshrc
}

function vim_install(){
    cecho "Installing NeoVim and others..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    crun sudo apt remove vim -y
    crun sudo apt remove vim-gtk -y

    crun sudo add-apt-repository ppa:neovim-ppa/unstable -y
    crun sudo apt update
    crun sudo apt install neovim -y

    crun sudo -H pip3 install pynvim yapf flake8 autopep8

    if command -v npm; then
        crun sudo npm -g install js-beautify eslint html-beautify css-beautify remark-cli
    else
        cecho "NOTE: npm was not installed, so some packages won't be installed here"
    fi

    # for keysound
    crun sudo apt install python3-sdl2 -y

    # zsh complete
    if command -v zmodload; then
        zmodload zsh/zpty
    fi

    crun sudo cp -f ../vim/.vimrc $HOME
    crun sudo cp -rf ../vim/.vim $HOME
    crun sudo cp -rf ../vim/.config/ $HOME

    crun sudo mkdir -p $HOME/.vim/plugged
    crun sudo chmod -R 777 $HOME/.vim

    crun nvim -c ':PlugInstall --sync | :qa!'
}

function python_install(){
    cecho "Installing Python and others..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    crun sudo apt install python-dev python3-dev python-pip python3-pip idle3 -y
    crun sudo -H pip3 install requests numpy scipy matplotlib thefuck
}

function tmux_install(){
    cecho "Installing tmux..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    crun sudo apt install tmux -y
    crun sudo cp -f ../tmux/.tmux.conf $HOME
}

function nodejs_install(){
    cecho "Installing nodejs and others..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    # nodejs
    crun curl -LO install-node.now.sh/lts
    crun sudo bash ./lts --yes
    crun rm ./lts
    # yarn
    crun curl --compressed -LO https://yarnpkg.com/install.sh
    crun sudo bash ./install.sh
    crun rm ./install.sh
    # npm
    crun sudo apt install npm -y
}

function ctags_install(){
    cecho "Installing ctags and others..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    crun git clone https://github.com/universal-ctags/ctags.git --depth=1
    crun sudo apt install autoconf -y
    crun sudo apt install pkg-config -y
    crun cd ctags
    crun ./autogen.sh
    crun ./configure
    crun sudo make
    crun sudo make install
    crun cd -
    crun rm -rf ctags
}

function font_install(){
    cecho "Installing Fonts..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    crun sudo mkdir -p ~/.local/share/fonts
    crun sudo cp ../fonts/* ~/.local/share/fonts
    crun cd ~/.local/share/fonts
    crun sudo mkfontscale
    crun sudo mkfontdir
    crun fc-cache -f -v
    crun cd -
}

function ccls_install() {
    cecho "Installing ccls..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    if [ ! -d "$HOME/Applications/ccls" ]; then
        crun git clone --depth=1 --recursive https://github.com/MaskRay/ccls
        crun cd ccls
        crun wget -c http://releases.llvm.org/7.0.1/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
        crun tar xf clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
        crun cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-16.04
        crun cmake --build Release
        crun rm clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
        crun rm -rf clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-16.04
        crun cd ..
        crun mkdir -p ~/Applications
        crun mv ccls ~/Applications/
    else
        cecho "NOTE: ccls has already been installed and won't be installed here"
    fi
}

function latex_install() {
    cecho "Installing latex..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    sudo apt install texlive -y
    sudo apt install texlive-lang-chinese -y
    sudo apt install texlive-xetex -y
    sudo apt install latexmk -y
}

function others_install(){
    cecho "Installing others..."
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    cfence ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    # gnome-tweak-tool
    crun sudo apt install gnome-tweak-tool -y
    # google-chrome
    crun sudo wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/
    crun wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
    crun sudo apt update
    crun sudo apt install google-chrome-stable -y
    # goldendict
    crun sudo apt install goldendict -y
    # netease-cloud-music
    crun wget -O netease-cloud-music.deb http://d1.music.126.net/dmusic/netease-cloud-music_1.1.0_amd64_ubuntu.deb
    crun sudo dpkg -i netease-cloud-music.deb
    crun sudo apt install -f
    # sougou-pinyin input method
    crun wget -O sogou-pinyin.deb http://pinyin.sogou.com/linux/download.php\?f\=linux\&bit\=64
    crun sudo dpkg -i sogou-pinyin.deb
    crun sudo apt install -f
}

function confirm_install(){
    while true; do
        echo "Install $1?[y/n]"
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
    initialize

    # Install by default
    common_install
    font_install
    python_install
    vim_install

    # Confirm needed install
    confirm_install tmux tmux_install
    confirm_install nodejs nodejs_install
    confirm_install ctags ctags_install
    confirm_install ccls ccls_install
    confirm_install latex latex_install
    echo "Others include: gnome-tweak | chrome | goldendict | netease-cloud-music | sougou-pinyin"
    confirm_install others others_install

    # oh_my_zsh
    oh_my_zsh_install
}

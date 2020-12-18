#! /bin/bash

OS=$(lsb_release -si)

arch_base() {
    # sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    # sudo cp ./sources/arch/mirrorlist /etc/pacman.d/mirrorlist
    sudo echo "[archlinuxcn]
    SigLevel = Optional TrustAll
    Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux-cn/$$arch
    " > /etc/pacman.conf
    sudo pacman -Syu
    sudo pacman -S yay openssh git wget curl unrar unzip tree xclip make cmake htop ranger trash-cli zathura zsh --noconfirm
    sudo pacman -S dconf-editor lsb-release mlocate cgdb proxychains zeal perl-rename vlc fd --noconfirm
    sudo pacman -S spectacle krunner --noconfirm
    sudo pacman -S wps-office-cn wps-office-mui-zh-cn --noconfirm
}

ubuntu_base() {
    # sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    # sudo cp ./sources/ubuntu/sources.list /etc/apt/sources.list
    sudo apt update && sudo apt upgrade -y
    sudo apt install openssh-client git wget curl unrar unzip tree xclip make cmake htop ranger gnome-tweak-tool zsh -y
    sudo apt install trash-cli -y
    sudo apt install zathura -y
    sudo apt install resolvconf -y
}

install_symlink() {
    DOTFILES=$(ls -A home -I .config -I .cargo -I .cgdb)
    CONFIGS=$(ls -A home/.config)
    for f in $DOTFILES; do
        ln -svf "$PWD/home/$f" $HOME
    done
    for f in $CONFIGS; do
        ln -svf "$PWD/home/.config/$f" $HOME/.config
    done
}

install_nvim() {
    if ! command -v nvim > /dev/null; then
        echo Installing nvim...
        case $OS in
            Arch)
                sudo pacman -S neovim --noconfirm;;
            Ubuntu)
                sudo apt remove vim -y
                sudo apt remove vim-gtk -y
                sudo add-apt-repository ppa:neovim-ppa/unstable -y
                sudo apt update
                sudo apt install neovim -y;;
        esac
    fi
    sudo pip3 install pynvim
    sudo pip3 install yapf
    sudo pip3 install flake8
    sudo pip3 install autopep8
    sudo pip3 install python-language-server
    sudo pip3 install pylint
    sudo pip3 install black
    sudo yarn global add neovim
    sudo yarn global add bash-language-server
    sudo yarn global add write-good
    sudo yarn global add markdownlint-cli
    nvim +PI +qa
}

install_ohmyzsh() {
    if ! command -v zsh > /dev/null; then
        case $OS in
            Arch)
                sudo pacman -S zsh --noconfirm;;
            Ubuntu)
                sudo apt install zsh -y;;
        esac
    fi
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo Installing oh-my-zsh...
        sh -c $(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)
        curl -L git.io/antigen > ~/.antigen.zsh
        for f in $DOTFILES; do
            ln -svf "$PWD/home/$f" $HOME
        done
        source ~/.zshrc
    fi
}

install_vim8() {
    if [ $OS == Ubuntu ]; then
        sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git
    fi
    git clone https://github.com/vim/vim  vim-master --depth 1
    cd vim-master
    make distclean
    # copied from https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/vim
    ./configure \
        --prefix=/usr \
        --localstatedir=/var/lib/vim \
        --with-features=huge \
        --enable-gpm \
        --enable-acl \
        --with-x=no \
        --disable-gui \
        --enable-multibyte \
        --enable-cscope \
        --enable-netbeans \
        --enable-perlinterp=dynamic \
        --enable-pythoninterp=dynamic \
        --enable-python3interp=dynamic \
        --enable-rubyinterp=dynamic \
        --enable-luainterp=dynamic \
        --enable-tclinterp=dynamic \
        --disable-canberra
            make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
            sudo make install
            sudo ln -sf /usr/local/bin/vim /usr/bin/vim
        }

install_fonts() {
    echo Installing fonts...
    sudo mkdir -p ~/.local/share/fonts
    sudo cp ../fonts/* ~/.local/share/fonts
    cd ~/.local/share/fonts
    sudo mkfontscale
    sudo mkfontdir
    fc-cache -f -v
    cd -

    if [ $OS = Arch ]; then
        yay -S otf-nerd-fonts-monacob-mono --noconfirm
    fi
}

install_nodejs() {
    if ! command -v node > /dev/null; then
        echo Installing nodejs...
        case $OS in
            Arch)
                sudo pacman -S node --noconfirm;;
            Ubuntu)
                curl -LO install-node.now.sh/lts
                sudo bash ./lts --yes
                rm ./lts;;
        esac
    fi
    if ! command -v yarn > /dev/null; then
        echo Installing yarn...
        case $OS in
            Arch)
                sudo pacman -S yarn --noconfirm;;
            Ubuntu)
                curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
                echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
                sudo apt update -y
                sudo apt install yarn -y
                yarn --version;;
        esac
    fi
}

install_python() {
    if ! command -v python >/dev/null; then
        echo Installing python...
        case $OS in
            Arch)
                sudo pacman -S python --noconfirm;;
            Ubuntu)
                sudo apt install python3-dev python3-pip idle3 -y;;
        esac
    fi
}

install_latex() {
    if ! command -v latex >/dev/null; then
        echo Installing latex...
        case $OS in
            Arch)
                sudo pacman -S texlive-core texlive-langchinese --noconfirm;;
            Ubuntu)
                sudo apt install texlive -y
                sudo apt install texlive-lang-chinese -y
                sudo apt install texlive-xetex -y
                sudo apt install latexmk -y;;
        esac
    fi
}

install_ccls() {
    if ! command -v ccls >/dev/null; then
        echo Installing ccls...
        case $OS in
            Arch)
                sudo pacman -S ccls --noconfirm;;
            Ubuntu)
                cwd=$PWD
                sudo apt install zlib1g-dev -y
                mkdir -p ~/Applications
                cd ~/Applications
                git clone --depth=1 --recursive https://github.com/MaskRay/ccls
                cd ccls
                wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
                tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
                cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
                cmake --build Release
                rm -rf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04*
                sudo ln -sf ~/Applications/ccls/Release/ccls /usr/bin/ccls
                cd $cwd;;
        esac
    fi
}

install_goldendict() {
    # NOTE: google translate for goldendict https://github.com/xinebf/google-translate-for-goldendict/
    if ! command -v goldendict >/dev/null; then
        echo Installing goldendict...
        # https://github.com/skywind3000/ECDICT/releases/download/1.0.28/ecdict-mdx-style-28.zip
        case $OS in
            Arch)
                sudo pacman -S goldendict --noconfirm;;
            Ubuntu)
                sudo apt install libdouble-conversion1 libqt5svg5 -y
                sudo apt install goldendict -y;;
        esac
    fi
}

install_ctags() {
    if ! command -v ctags >/dev/null; then
        echo Installing ctags...
        # https://github.com/skywind3000/ECDICT/releases/download/1.0.28/ecdict-mdx-style-28.zip
        case $OS in
            Arch)
                sudo pacman -S ctags --noconfirm;;
            Ubuntu)
                git clone https://github.com/universal-ctags/ctags.git --depth=1
                sudo apt install autoconf -y
                sudo apt install pkg-config -y
                cd ctags
                ./autogen.sh
                ./configure
                sudo make
                sudo make install
                cd -
                rm -rf ctags;;
        esac
    fi
}

install_gtags() {
    if ! command -v gtags >/dev/null; then
        echo Installing gtags...
        case $OS in
            Arch)
                yay -S global --noconfirm;;
            Ubuntu)
                sudo apt install automake autoconf flex bison gperf libtool libtool-bin texinfo -y
                # The latest version is v6.6.3 for now
                # https://www.gnu.org/software/global/download.html
                wget -c http://tamacom.com/global/global-6.6.3.tar.gz
                tar -xf global-6.6.3.tar.gz
                cd global-6.6.3
                sh reconf.sh
                ./configure
                make
                sudo make install
                sudo pip3 install pygments
                cd ..
                rm -rf global-6.6.3.tar.gz
                rm -rf global-6.6.3;;
        esac
    fi
}

install_rg() {
    if ! command -v rg >/dev/null; then
        echo Installing rg...
        case $OS in
            Arch)
                sudo pacman -S ripgrep --noconfirm;;
            Ubuntu)
                wget -O rg.deb https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
                sudo dpkg -i rg.deb
                rm rg.deb;;
        esac
    fi
}


install_fzf() {
    if ! command -v fzf >/dev/null; then
        echo Installing fzf...
        # Arch only
        # sudo pacman -S fzf --noconfirm
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    fi
}


install_ncdu() {
    if ! command -v ncdu >/dev/null; then
        echo Installing ncdu...
        case $OS in
            Arch)
                sudo pacman -S ncdu --noconfirm;;
            Ubuntu)
                curl -LO https://dev.yorhel.nl/download/ncdu-1.14.tar.gz
                tar -xf ncdu-1.14.tar.gz
                cd ncdu-1.14
                sudo apt install libncurses5-dev libncursesw5-dev -y
                ./configure --prefix=/usr
                sudo make
                sudo make install
                cd ..
                rm -rf ncdu*;;
        esac
    fi
}


install_v2ray() {
    if [ ! -d "/etc/v2ray" ]; then
        if [[ $OS != Arch ]]; then
            echo Installing v2ray...
            curl -LO -s https://install.direct/go.sh
            sudo bash go.sh
            rm -f go.sh
        else
            sudo pacman -S v2ray --noconfirm
        fi
    fi
}


install_peek() {
    if ! command -v peek >/dev/null; then
        echo Installing peek...
        case $OS in
            Arch)
                sudo pacman -S peek --noconfirm;;
            Ubuntu)
                sudo add-apt-repository ppa:peek-developers/stable -y
                sudo apt update
                sudo apt install peek -y;;
        esac
    fi
}

install_chrome() {
    if ! command -v google-chrome >/dev/null; then
        echo Installing google-chrome...
        case $OS in
            Arch)
                yay -S google-chrome --noconfirm;;
            Ubuntu)
                sudo wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/
                wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
                sudo apt update
                sudo apt install google-chrome-stable -y;;
        esac
    fi
}


install_netease_cloud_music() {
    if ! command -v netease-cloud-music >/dev/null; then
        echo Installing netease-cloud-music...
        case $OS in
            Arch)
                sudo pacman -S netease-cloud-music --noconfirm;;
            Ubuntu)
                wget -O netease-cloud-music.deb http://d1.music.126.net/dmusic/netease-cloud-music_1.1.0_amd64_ubuntu.deb
                sudo dpkg -i netease-cloud-music.deb
                sudo apt install -f
                rm netease-cloud-music.deb;;
        esac
    fi
}

install_sogou_pinyin() {
    case $OS in
        Arch)
            sudo pacman -S fcitx-lilydjwg-git fcitx-sogoupinyin --noconfirm;;
        Ubuntu)
            wget -O sogou-pinyin.deb http://pinyin.sogou.com/linux/download.php\?f\=linux\&bit\=64
            sudo dpkg -i sogou-pinyin.deb
            sudo apt install -f
            rm sogou-pinyin.deb;;
    esac
}

#! /bin/bash

if uname -r | grep arch &> /dev/null
then
    OS=Arch
else
    OS=Ubuntu # TODO
fi

arch_base() {
    # sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    # sudo cp ./sources/arch/mirrorlist /etc/pacman.d/mirrorlist
    echo "[archlinuxcn]\nSigLevel = Optional TrustAll\nServer = https://mirrors.sjtug.sjtu.edu.cn/archlinux-cn/\$arch" | sudo tee -a /etc/pacman.conf
    sudo pacman -Syy && sudo pacman -S archlinuxcn-keyring

    sudo pacman -Syu
    sudo pacman -S openssh git wget curl unrar unzip tree xclip make cmake htop ranger trash-cli zathura zsh --noconfirm
    sudo pacman -S dconf-editor lsb-release mlocate cgdb proxychains zeal perl-rename vlc fd --noconfirm
    sudo pacman -S spectacle krunner man-pages v2ray peek --noconfirm
    sudo pacman -S wps-office-cn wps-office-mui-zh-cn --noconfirm
    sudo pacman -S httpie mlocate core/inetutils --noconfirm

    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

    # yay -S cppman cheat-bin
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

install_fonts() {
    echo Installing fonts...
    sudo mkdir -p ~/.local/share/fonts
    sudo cp ../fonts/* ~/.local/share/fonts
    cd ~/.local/share/fonts
    sudo mkfontscale
    sudo mkfontdir
    fc-cache -fv
    cd -

    # emoji
    sudo pacman -S noto-fonts-emoj --noconfirm

    # monaco nerd font
    yay -S otf-nerd-fonts-monacob-mono --noconfirm
}

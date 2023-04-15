__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

sudo gpasswd -a $USER input

ensure_installed libinput
ensure_installed xf86-input-libinput
ensure_installed wmctrl
ensure_installed xdotool

if ! command -v libinput-gestures &> /dev/null
then
    yay -S libinput-gestures --noconfirm
fi

sudo cp /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d/

ln -sf "$__dirname/libinput-gestures.conf" "$HOME/.config"

libinput-gestures-setup autostart
libinput-gestures-setup start

echo "Need relogin"

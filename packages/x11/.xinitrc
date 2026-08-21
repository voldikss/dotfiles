export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
export LC_ALL="zh_CN.UTF-8"

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export INPUT_METHOD=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus # for kitty

setxkbmap -option caps:escape

fcitx5 -d &

if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

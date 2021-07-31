# no global variables here!!!

ensure_python() {
    __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if ! command -v pip3 &> /dev/null
    then
        bash "$__dirname/pip/setup.sh"
    fi
}

ensure_nodejs() {
    __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if ! command -v nodejs &> /dev/null
    then
        bash "$__dirname/nodejs/setup.sh"
    fi
}

ensure_proxychains() {
    echo
}

ensure_folder() {
    if ! test -d "$1"
    then
        rm -rf "$1"
    fi
    mkdir -p "$1"
}

ensure_installed() {
    if ! pacman -Qi $1 &> /dev/null
    then
        sudo pacman -S $1 --noconfirm
    fi
}

#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES_DIR="$REPO_DIR/packages"
SYSTEM_DIR="$REPO_DIR/system"

usage() {
  cat <<'USAGE'
Usage:
  ./install.sh [options] [package ...]

  Install GNU Stow packages from this repository.

Options:
  -s, --system    install system packages instead of home packages
  -a, --all       install all packages for the selected mode
  -l, --list      list available packages for the selected mode
  -h, --help      show this help

Examples:
  ./install.sh zsh git tmux nvim
  ./install.sh -a
  ./install.sh -s -l
  sudo ./install.sh -s pacman network docker
USAGE
}

list_packages() {
  local dir="$1"
  find "$dir" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort
}

require_stow() {
  if ! command -v stow >/dev/null 2>&1; then
    echo "error: GNU Stow is not installed." >&2
    echo "Install it first, e.g.: sudo pacman -S stow   # Arch" >&2
    echo "                      sudo apt install stow    # Debian/Ubuntu" >&2
    exit 1
  fi
}

MODE=home
ALL=0
LIST=0

while getopts "sahl" OPT; do
  case "$OPT" in
    s) MODE=system ;;
    a) ALL=1 ;;
    l) LIST=1 ;;
    h) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
done
shift $((OPTIND - 1))

if [ "$LIST" -eq 1 ]; then
  if [ "$MODE" = home ]; then
    list_packages "$PACKAGES_DIR"
  else
    list_packages "$SYSTEM_DIR"
  fi
  exit 0
fi

if [ "$ALL" -eq 1 ]; then
  if [ "$#" -ne 0 ]; then
    echo "error: --all cannot be combined with package names." >&2
    exit 2
  fi
  if [ "$MODE" = home ]; then
    mapfile -t PACKAGES < <(list_packages "$PACKAGES_DIR")
  else
    mapfile -t PACKAGES < <(list_packages "$SYSTEM_DIR")
  fi
else
  if [ "$#" -eq 0 ]; then
    usage >&2
    exit 2
  fi
  PACKAGES=("$@")
fi

if [ "$MODE" = home ]; then
  STOW_DIR="$PACKAGES_DIR"
  TARGET="$HOME"
else
  STOW_DIR="$SYSTEM_DIR"
  TARGET="/"
fi

for pkg in "${PACKAGES[@]}"; do
  if [ ! -d "$STOW_DIR/$pkg" ]; then
    echo "error: unknown package: $pkg" >&2
    echo "Run './install.sh $([ "$MODE" = home ] || echo -n "-s ")-l' to list available packages." >&2
    exit 1
  fi
done

require_stow

if [ "$MODE" = system ] && [ "$(id -u)" -ne 0 ]; then
  echo "Re-running with sudo for system packages..."
  exec sudo "$0" --system "${PACKAGES[@]}"
fi

stow --dir="$STOW_DIR" --target="$TARGET" --restow "${PACKAGES[@]}"

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
  GNU Stow is installed automatically using the available package manager.

Options:
  -s, --system    install system packages instead of home packages
  -a, --all       install all packages for the selected mode
  -f, --force     replace conflicting files and symlinks (not directories)
  -l, --list      list available packages for the selected mode
  -h, --help      show this help

Examples:
  ./install.sh zsh git tmux nvim
  ./install.sh -a
  ./install.sh -f python
  ./install.sh -s -l
  sudo ./install.sh -s pacman network docker
USAGE
}

list_packages() {
  local dir="$1"
  find "$dir" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort
}

run_with_privileges() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    echo "error: sudo is required to install GNU Stow, but it is not available." >&2
    echo "Install stow manually or run this script as root." >&2
    exit 1
  fi
}

install_stow() {
  if command -v stow >/dev/null 2>&1; then
    return
  fi

  echo "GNU Stow is not installed; installing it..."

  if command -v pacman >/dev/null 2>&1; then
    run_with_privileges pacman -S --needed --noconfirm stow
  elif command -v apt-get >/dev/null 2>&1; then
    run_with_privileges env DEBIAN_FRONTEND=noninteractive apt-get install -y stow
  elif command -v dnf >/dev/null 2>&1; then
    run_with_privileges dnf install -y stow
  elif command -v yum >/dev/null 2>&1; then
    run_with_privileges yum install -y stow
  elif command -v zypper >/dev/null 2>&1; then
    run_with_privileges zypper --non-interactive install stow
  elif command -v apk >/dev/null 2>&1; then
    run_with_privileges apk add stow
  elif command -v brew >/dev/null 2>&1; then
    brew install stow
  elif command -v emerge >/dev/null 2>&1; then
    run_with_privileges emerge --ask=n app-admin/stow
  else
    echo "error: could not find a supported package manager to install GNU Stow." >&2
    echo "Install stow manually, then run this script again." >&2
    exit 1
  fi

  if ! command -v stow >/dev/null 2>&1; then
    echo "error: GNU Stow installation did not complete successfully." >&2
    exit 1
  fi
}

remove_conflicts() {
  local pkg source relative target_path parent
  local -a conflicts=()
  local -A seen=()

  for pkg in "${PACKAGES[@]}"; do
    while IFS= read -r -d '' source; do
      relative="${source#"$STOW_DIR/$pkg/"}"
      target_path="$TARGET/$relative"

      if [ -d "$source" ] && [ ! -L "$source" ]; then
        if [ -d "$target_path" ]; then
          if [ -L "$target_path" ] && [ ! "$source" -ef "$target_path" ]; then
            echo "error: refusing to replace symlinked directory: $target_path" >&2
            return 1
          fi
          continue
        fi
      elif [ -d "$target_path" ] && [ ! -L "$target_path" ]; then
        echo "error: refusing to replace directory: $target_path" >&2
        return 1
      fi

      if [ ! -e "$target_path" ] && [ ! -L "$target_path" ]; then
        continue
      fi
      if [ "$source" -ef "$target_path" ]; then
        continue
      fi

      parent="${target_path%/*}"
      while [ "$parent" != "$TARGET" ] && [ "$parent" != / ]; do
        if [ -L "$parent" ]; then
          echo "error: refusing to replace file beneath symlinked directory: $target_path" >&2
          return 1
        fi
        parent="${parent%/*}"
      done

      if [ -n "${seen[$target_path]+x}" ] && [ "${seen[$target_path]}" != "$source" ]; then
        echo "error: multiple packages would replace the same target: $target_path" >&2
        return 1
      fi
      if [ -z "${seen[$target_path]+x}" ]; then
        seen[$target_path]="$source"
        conflicts+=("$target_path")
      fi
    done < <(find "$STOW_DIR/$pkg" -mindepth 1 \( -name .git -o -name .stow-local-ignore \) -prune -o -print0)
  done

  for target_path in "${conflicts[@]}"; do
    rm -- "$target_path"
  done
}

MODE=home
ALL=0
LIST=0
FORCE=0

while [ "$#" -gt 0 ]; do
  case "$1" in
    -s|--system) MODE=system; shift ;;
    -a|--all) ALL=1; shift ;;
    -f|--force) FORCE=1; shift ;;
    -l|--list) LIST=1; shift ;;
    -h|--help) usage; exit 0 ;;
    --) shift; break ;;
    -*) usage >&2; exit 2 ;;
    *) break ;;
  esac
done

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
  if [ "$pkg" = . ] || [ "$pkg" = .. ] || [[ "$pkg" == */* ]] || [ ! -d "$STOW_DIR/$pkg" ]; then
    echo "error: unknown package: $pkg" >&2
    if [ "$MODE" = home ]; then
      echo "Run './install.sh -l' to list available packages." >&2
    else
      echo "Run './install.sh -s -l' to list available packages." >&2
    fi
    exit 1
  fi
done

install_stow

if [ "$MODE" = system ] && [ "$(id -u)" -ne 0 ]; then
  echo "Re-running with sudo for system packages..."
  if [ "$FORCE" -eq 1 ]; then
    exec sudo "$0" -s -f "${PACKAGES[@]}"
  fi
  exec sudo "$0" -s "${PACKAGES[@]}"
fi

if [ "$FORCE" -eq 1 ]; then
  remove_conflicts
fi

stow --dir="$STOW_DIR" --target="$TARGET" --restow "${PACKAGES[@]}"

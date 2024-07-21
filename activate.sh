#!/usr/bin/env bash

set -euo pipefail

install_module() {
  if ! [[ -d "$1" ]]; then
    echo "Module '$1' does not exist."
    exit 1
  fi

  preinstall_script=${1}/pre-install.sh
  if [[ -f $preinstall_script ]]; then
    ./${preinstall_script}
  fi

  custom_stow=${1}/stow-custom.sh
  if [[ -f $custom_stow ]]; then
    ./${custom_stow}
  else
    stow --verbose --target=$HOME --restow $1
  fi

  postinstall_script=${1}/post-install.sh
  if [[ -f $postinstall_script ]]; then
    ./${postinstall_script}
  fi
}

install_cli_tools() {
  if ! type "curl" >/dev/null; then
    echo "curl not found. Installing..."
    brew install curl
  fi
}

install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

install_stow() {
  if ! command -v stow >/dev/null 2>&1; then
    echo "Stow not found. Installing..."
    brew install stow
  fi
}

if [ $# -eq 0 ]; then
  echo "No parameters were provided. You must specify 'all' or a specific module."
  echo "  i.e. './activate all'"
  exit 1
fi

install_homebrew
install_cli_tools
install_stow

case $1 in
all)
  for dir in *; do
    if [[ -d "$dir" && ! -L "$dir" ]]; then
      install_module ${dir}
    fi
  done
  ;;
*)
  install_module $1
  ;;
esac

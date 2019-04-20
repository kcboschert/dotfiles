#!/usr/bin/env bash

set -euo pipefail

install_module () {
  if ! [[ -d "$1" ]]; then
    echo "Module '$1' does not exist."
    exit 1
  fi

  preinstall_script=${1}/pre-install.sh
  if [[ -f $preinstall_script ]]; then
    ./${preinstall_script}
  fi

  stow --verbose --target=$HOME --restow $1

  postinstall_script=${1}/post-install.sh
  if [[ -f $postinstall_script ]]; then
    ./${postinstall_script}
  fi
}

if [ $# -eq 0 ]; then
  echo "No parameters were provided. You must specify 'all' or a specific module."
  echo "  i.e. './activate all'"
  exit 1
fi

if [[ "$(uname)" == "Darwin" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Installing..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
elif [[ "$(uname)" == "Linux" ]]; then
  if ! command -v stow >/dev/null 2>&1; then
    echo "Stow not found. Installing..."
    sudo apt-get install stow
  fi
fi

case $1 in
  all )
    for dir in *; do
      if [[ -d "$dir" && ! -L "$dir" ]]; then
        install_module ${dir}
      fi
    done
    ;;
  * )
    install_module $1
    ;;
esac

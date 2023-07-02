#!/usr/bin/env bash

set -euo pipefail

function install_nvim_linux() {
  sudo apt-get install gcc g++ ripgrep

  curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
  tar xzvf nvim.tar.gz
  sudo cp -r nvim-linux64/* /usr/local
  rm -rf nvim-linux64 nvim.tar.gz
}

if [[ "$(uname)" == "Darwin" ]]; then
  if [ -f ~/.nvm/nvm.sh ]; then
    brew install nvm
    . ~/.nvm/nvm.sh
  fi
  nvm install --lts

  brew install neovim ripgrep boost pybind11
elif [[ "$(uname)" == "Linux" ]]; then
  if ! command -v nvim $>/dev/null; then
    install_nvim_linux
  fi
  sudo apt-get install openjdk-17-jdk checkstyle
fi

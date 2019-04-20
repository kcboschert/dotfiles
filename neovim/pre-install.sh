#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname)" == "Darwin" ]]; then
  if [ -f ~/.nvm/nvm.sh ]; then
    brew install nvm
    . ~/.nvm/nvm.sh
  fi
  nvm install --lts

  brew install neovim
elif [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install neovim
fi

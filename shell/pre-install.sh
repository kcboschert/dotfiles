#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname)" == "Darwin" ]]; then
  brew tap homebrew/command-not-found
  brew install bash zsh
elif [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get install command-not-found zsh
fi

if ! command -v asdf $ >/dev/null; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
fi

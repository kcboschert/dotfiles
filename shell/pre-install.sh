#!/usr/bin/env bash

set -euo pipefail

if ! command -v zsh $>/dev/null; then
  if [[ "$(uname)" == "Darwin" ]]; then
    brew install zsh
  elif [[ "$(uname)" == "Linux" ]]; then
    sudo apt-get install zsh
  fi
fi

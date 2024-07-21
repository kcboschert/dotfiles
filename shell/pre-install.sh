#!/usr/bin/env bash

set -euo pipefail

brew tap homebrew/command-not-found
brew install bash zsh
# echo "Adding zsh as a valid login shell..."
# sudo sh -c "echo $(which zsh) >> /etc/shells"
# echo "Setting zsh as default shell..."
# chsh -s $(which zsh)

if ! command -v asdf $ >/dev/null; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
fi

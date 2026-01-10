#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

brew install \
  font-caskaydia-mono-nerd-font \
  font-fira-code-nerd-font \
  font-hack-nerd-font

if [[ "$(uname)" == "Darwin" ]]; then
  brew install wezterm --appdir ~/Applications
elif [[ "$(uname)" == "Linux" ]]; then
  if ! command -v wezterm >/dev/null 2>&1; then
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
    sudo apt-get update
  fi
  sudo apt-get install wezterm
fi

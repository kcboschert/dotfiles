#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

REPO_PATH="/etc/apt/sources.list.d/wezterm.list"

if [[ "$(uname)" == "Linux" ]]; then
  if [[ -f "$REPO_PATH" ]]; then
    exit 0
  fi

  echo "Installing Wezterm repository..."

  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
  sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
  echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee "$REPO_PATH"
  sudo apt-get update

  echo "Wezterm setup completed."
fi

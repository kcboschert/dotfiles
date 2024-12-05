#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

if [[ "$(uname)" == "Darwin" ]]; then
	exit 0
fi

sudo apt update && sudo apt install -y gnupg
gpg --keyserver keyserver.ubuntu.com --recv 0xfaf1020699503176
gpg --export 0xfaf1020699503176 | sudo tee /usr/share/keyrings/ulauncher-archive-keyring.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/ulauncher-archive-keyring.gpg] \
          http://ppa.launchpad.net/agornostal/ulauncher/ubuntu jammy main" |
	sudo tee /etc/apt/sources.list.d/ulauncher-jammy.list

sudo apt-get update && sudo apt-get install ulauncher

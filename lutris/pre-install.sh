#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

if [[ "$(uname)" == "Darwin" ]]; then
	exit 0
fi

echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list >/dev/null

wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg >/dev/null

sudo apt-get update
sudo apt-get install lutris

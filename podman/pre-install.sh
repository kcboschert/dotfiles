#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

brew install podman \
	docker-compose

# if we're on linux, install the uidmap package
if [[ "$(uname)" == "Linux" ]]; then
	sudo apt-get install uidmap
fi

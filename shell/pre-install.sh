#!/usr/bin/env bash

set -euo pipefail

if ! command -v zsh $ >/dev/null; then
	if [[ "$(uname)" == "Darwin" ]]; then
		brew install zsh
	elif [[ "$(uname)" == "Linux" ]]; then
		sudo apt-get install zsh
	fi
fi

if ! command -v asdf $ >/dev/null; then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
fi

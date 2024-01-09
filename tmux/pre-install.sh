#!/usr/bin/env bash

set -euo pipefail

if ! command -v tmux $ >/dev/null; then
	if [[ "$(uname)" == "Darwin" ]]; then
		brew install tmux
	elif [[ "$(uname)" == "Linux" ]]; then
		sudo apt-get install tmux
	fi
fi

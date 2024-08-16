#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname)" == "Darwin" ]]; then
	brew install \
		font-caskaydia-mono-nerd-font \
		font-fira-code-nerd-font
fi

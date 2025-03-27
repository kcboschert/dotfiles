#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

source ./util.sh

if ! command -v aider &>/dev/null; then
	echo "aider could not be found, installing..."
	python -m pip install aider-install
	aider-install
fi

if ! command -v ollama &>/dev/null; then
	if prompt "\nollama not found. Install?"; then
		echo "Installing ollama..."
		curl -fsSL https://ollama.com/install.sh | sh
	else
		echo "ollama installation skipped."
	fi
fi

#!/usr/bin/env bash

set -euo pipefail

function install_nvim_linux() {
	sudo apt-get install gcc g++

	curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
	tar xzvf nvim.tar.gz
	sudo cp -r nvim-linux64/* /usr/local
	rm -rf nvim-linux64 nvim.tar.gz
}

if [[ "$(uname)" == "Linux" ]] && ! command -v brew >/dev/null 2>&1; then
	install_nvim_linux
	sudo apt-get install bison ripgrep
else
	brew install neovim bison ripgrep pybind11
fi

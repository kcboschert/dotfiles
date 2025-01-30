#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

function install_nvim_linux() {
	sudo apt-get install gcc g++

	curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
	tar xzvf nvim.tar.gz
	sudo cp -r nvim-linux-x86_64/* /usr/local
	rm -rf nvim-linux-x86_64 nvim.tar.gz
}

if [[ "$(uname)" == "Linux" ]] && ! command -v brew >/dev/null 2>&1; then
	install_nvim_linux
	sudo apt-get install bison ripgrep fzf luarocks
else
	brew install neovim bison ripgrep pybind11 fd lazygit fzf luarocks
fi

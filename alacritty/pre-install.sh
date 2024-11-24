#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname)" == "Darwin" ]]; then
	brew install \
		alacritty \
		font-caskaydia-mono-nerd-font \
		font-fira-code-nerd-font
elif [[ "$(uname)" == "Linux" ]]; then
	if ! command -v alacritty >/dev/null 2>&1; then
		# alacritty dependencies on debian
		# https://github.com/alacritty/alacritty/blob/master/INSTALL.md
		sudo apt-get install cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
		# need cargo for installing
		curl https://sh.rustup.rs -sSf | sh

		cargo install alacritty

		# setup desktop entry
		git clone git@github.com:alacritty/alacritty.git alacritty-install
		pushd alacritty-install
		sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
		sudo desktop-file-install extra/linux/Alacritty.desktop
		sudo update-desktop-database
		popd
		rm -rf alacritty-install
	fi
fi

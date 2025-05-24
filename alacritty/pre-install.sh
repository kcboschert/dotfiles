#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

brew install \
	font-caskaydia-mono-nerd-font \
	font-fira-code-nerd-font \
	font-hack-nerd-font

if [[ "$(uname)" == "Darwin" ]]; then
	brew install alacritty
elif [[ "$(uname)" == "Linux" ]]; then
	if ! command -v alacritty >/dev/null 2>&1; then
		# alacritty dependencies on debian
		# https://github.com/alacritty/alacritty/blob/master/INSTALL.md
		sudo apt-get install cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
		# need cargo for installing
		if ! command -v cargo >/dev/null 2>&1; then
			curl https://sh.rustup.rs -sSf | sh
		fi

		cargo install alacritty
		if [[ ! -f /usr/local/bin/alacritty ]]; then
			ln -s "$(which alacritty)" /usr/local/bin/alacritty
		fi

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

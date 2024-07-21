#!/usr/bin/env bash

set -euo pipefail

install_tpm() {
	if [ ! -d ${HOME}/.tmux/plugins ]; then
		git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
	else
		pushd ${HOME}/.tmux/plugins
		git pull
		popd
	fi
}

install_theme_prereqs() {
	# music statusbar
	if [[ "$(uname)" == "Darwin" ]]; then
		brew install nowplaying-cli
	elif [[ "$(uname)" == "Linux" ]]; then
		sudo apt-get install playerctl
	fi

	brew install bash bc coreutils gawk gsed jq
}

brew install tmux
install_tpm
install_theme_prereqs

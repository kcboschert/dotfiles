#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

install_zgenom() {
	if [ ! -d ${HOME}/.zgenom ]; then
		git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
	else
		pushd ${HOME}/.zgenom
		git pull
		popd
	fi
}

brew tap homebrew/command-not-found
brew install bash zsh starship gum bottom dust
# echo "Adding zsh as a valid login shell..."
# sudo sh -c "echo $(which zsh) >> /etc/shells"
# echo "Setting zsh as default shell..."
# chsh -s $(which zsh)

if ! command -v mise $ >/dev/null; then
	brew install mise
	mkdir -p /etc/bash_completion.d/
	mise completion bash >/etc/bash_completion.d/mise
fi

install_zgenom

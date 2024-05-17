#!/usr/bin/env bash

set -euo pipefail

# Install/Update zplug

if [ ! -d ${HOME}/.zplug ]; then
	git clone https://github.com/zplug/zplug.git "${HOME}/.zplug"
else
	pushd ${HOME}/.zplug
	git pull
	popd
fi

if [[ "$(uname)" == "Darwin" ]]; then
	if ! command -v gls >/dev/null 2>&1; then
		brew install \
			coreutils \
			libyaml # required for installing ruby versions with psych
	fi
	brew tap homebrew/cask-fonts
	for pkg in \
		font-fira-code-nerd-font \
		gawk \
		gnu-sed \
		gnu-tar \
		gnu-which \
		gpg \
		grep; do
		brew install ${pkg}
	done
fi

# Install asdf plugins for common languages
echo ""
echo "Installing asdf Version Manager plugins for languages..."
source ~/.asdf/asdf.sh

declare -A plugins
plugins[nodejs]=https://github.com/asdf-vm/asdf-nodejs.git
plugins[ruby]=https://github.com/asdf-vm/asdf-ruby
plugins[golang]=https://github.com/asdf-community/asdf-golang.git
plugins[python]=https://github.com/asdf-community/asdf-python.git

for lang in "${!plugins[@]}"; do
	if ! asdf list | grep ${lang} >/dev/null 2>&1; then
		echo "    ${lang} Installing..."
		asdf plugin add ${lang} ${plugins[$lang]}
		asdf install ${lang} latest
		asdf global ${lang} latest
		echo "    ...done."
	else
		echo "    ${lang} already installed!"
	fi
done

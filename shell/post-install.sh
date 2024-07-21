#!/usr/bin/env bash

set -euo pipefail

install_zplug() {
	if [ ! -d ${HOME}/.zplug ]; then
		git clone https://github.com/zplug/zplug.git "${HOME}/.zplug"
	else
		pushd ${HOME}/.zplug
		git pull
		popd
	fi
}

install_cli_tools() {
	if [[ "$(uname)" == "Darwin" ]]; then
		brew install \
			coreutils \
			libyaml \
			font-fira-code-nerd-font \
			gawk \
			gnu-sed \
			gnu-tar \
			gnu-which \
			gpg \
			grep
	fi
	brew install acl
}

install_languages() {
	# Install asdf plugins for common languages
	echo ""
	echo "Installing asdf Version Manager plugins for languages..."
	source ~/.asdf/asdf.sh

	declare -A plugins
	plugins[nodejs]=https://github.com/asdf-vm/asdf-nodejs.git
	plugins[ruby]=https://github.com/asdf-vm/asdf-ruby
	plugins[golang]=https://github.com/asdf-community/asdf-golang.git
	plugins[python]=https://github.com/asdf-community/asdf-python.git
	plugins[java]=https://github.com/halcyon/asdf-java.git

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

	asdf install java openjdk-11.0.2
	asdf install java openjdk-17.0.2
	asdf install java openjdk-21.0.2
}

install_atuin() {
	echo "Installing Atuin shell history manager..."
	brew install atuin
}

install_zplug
install_cli_tools
install_languages
install_atuin

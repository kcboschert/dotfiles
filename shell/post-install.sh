#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

install_cli_tools() {
	if [[ "$(uname)" == "Darwin" ]]; then
		brew install \
			coreutils \
			libyaml \
			gawk \
			gnu-sed \
			gnu-tar \
			gnu-which \
			gpg \
			grep
	elif [[ "$(uname)" == "Linux" ]]; then
		brew install acl
	fi
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
	plugins[dotnet]=https://github.com/hensou/asdf-dotnet.git

	for lang in "${!plugins[@]}"; do
		if ! asdf list | grep ${lang} >/dev/null 2>&1; then
			echo "    ${lang} Installing..."

			asdf plugin add ${lang} ${plugins[$lang]}

			if [[ "${lang}" == "java" ]]; then
				asdf install java openjdk-11.0.2
				asdf install java openjdk-17.0.2
				asdf install java openjdk-21.0.2
			else
				asdf install ${lang} latest
				asdf global ${lang} latest
			fi

			echo "    ...done."
		else
			echo "    ${lang} already installed!"
		fi
	done
}

install_atuin() {
	echo "Installing Atuin shell history manager..."
	brew install atuin
}

install_cli_tools
install_languages
install_atuin

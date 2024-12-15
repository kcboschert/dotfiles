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
	echo "Installing mise Version Manager plugins for languages..."

	declare -a languages=("nodejs" "ruby" "go" "python" "java" "dotnet")

	for lang in "${languages[@]}"; do
		if ! mise ls --installed | grep "${lang}" >/dev/null 2>&1; then
			echo "    ${lang} Installing..."

			mise install "${lang}"@latest

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

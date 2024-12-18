#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

prompt() {
	while true; do
		message=$1
		read -p "${message} [y/n]" -n 1 -r yn

		case $yn in
		[Yy]) return 0 ;;
		[Nn]) return 1 ;;
		*) echo "Invalid response." ;;
		esac
	done
}

install_module() {
	if ! [[ -d "$1" ]]; then
		echo "Module '$1' does not exist."
		exit 1
	fi

	echo ""
	echo "---------- INSTALLING MODULE '${1}' ----------"
	echo ""

	preinstall_script=${1}/pre-install.sh
	if [[ -f $preinstall_script ]]; then
		./${preinstall_script}
	fi

	custom_stow=${1}/stow-custom.sh
	if [[ -f $custom_stow ]]; then
		./${custom_stow}
	else
		stow --verbose --target=$HOME --restow $1
	fi

	postinstall_script=${1}/post-install.sh
	if [[ -f $postinstall_script ]]; then
		./${postinstall_script}
	fi
}

install_cli_tools() {
	if ! type "curl" >/dev/null; then
		echo "\ncurl not found. Installing..."
		brew install curl
	fi
	if ! command -v git >/dev/null 2>&1; then
		echo "\ngit not found. Installing..."
		brew install git
	fi
}

install_homebrew() {
	if ! command -v brew >/dev/null 2>&1; then
		if prompt "\nHomebrew not found. Many modules require this prerequisite. Install?"; then
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		fi
	fi
}

install_stow() {
	if ! command -v stow >/dev/null 2>&1; then
		echo "\nStow not found. Installing..."
		if ! command -v brew >/dev/null 2>&1; then
			sudo apt-get install stow
		else
			brew install stow
		fi
	fi
}

if [ $# -eq 0 ]; then
	echo "No parameters were provided. You must specify 'all' or a specific module."
	echo "  i.e. './activate all'"
	exit 1
fi

if [[ "$(uname)" == "Linux" ]]; then
	sudo apt-get update
	if ! dpkg -l | grep build-essential >/dev/null 2>&1; then
		sudo apt-get install build-essential
	fi
fi

install_cli_tools
install_homebrew
install_stow

case $1 in
all)
	for dir in *; do
		if [[ -d "$dir" && ! -L "$dir" ]]; then
			install_module ${dir}
		fi
	done
	;;
*)
	install_module $1
	;;
esac

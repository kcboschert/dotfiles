#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

source ./util.sh

install_module() {
	local module_dir=$1

	if ! [[ -d "$module_dir" ]]; then
		echo "Module '$module_dir' does not exist."
		return 1
	fi

	echo ""
	echo "---------- INSTALLING MODULE '${module_dir}' ----------"
	echo ""

	local preinstall_script="${module_dir}/pre-install.sh"
	if [[ -f $preinstall_script ]]; then
		echo "Running pre-install script for ${module_dir}..."
		./"${preinstall_script}"
	fi

	local custom_stow="${module_dir}/stow-custom.sh"
	if [[ -f $custom_stow ]]; then
		echo "Running custom stow script for ${module_dir}..."
		./"${custom_stow}"
	else
		stow --verbose --target="$HOME" --restow "${module_dir}"
	fi

	local postinstall_script="${module_dir}/post-install.sh"
	if [[ -f $postinstall_script ]]; then
		echo "Running post-install script for ${module_dir}..."
		./"${postinstall_script}"
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
		else
			echo "Homebrew installation skipped."
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
		echo "\nbuild-essential not found. Installing..."
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
			install_module "${dir}"
		fi
	done
	;;
*)
	install_module "$1"
	;;
esac

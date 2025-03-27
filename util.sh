#!/usr/bin/env bash

prompt() {
	local message=$1
	while true; do
		read -p "${message} [y/n]" -n 1 -r yn

		case $yn in
		[Yy]) return 0 ;;
		[Nn]) return 1 ;;
		*) echo "Invalid response. Please answer with 'y' or 'n'." ;;
		esac
	done
}

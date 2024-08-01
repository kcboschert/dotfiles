#!/usr/bin/env bash

set -euo pipefail

if command -v brew >/dev/null 2>&1; then
	brew install ctags jq
else
	sudo apt-get install jq
fi

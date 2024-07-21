#!/usr/bin/env bash

set -euo pipefail

if ! command -v tmux $ >/dev/null; then
	brew install tmux
fi

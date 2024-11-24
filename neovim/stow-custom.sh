#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

mkdir -p $HOME/.config
stow --verbose --target=$HOME/.config --restow neovim

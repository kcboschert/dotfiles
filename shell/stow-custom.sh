#!/usr/bin/env bash

mkdir -p $HOME/.config
stow -n --verbose --ignore='atuin/.*' --restow shell
stow -n --verbose --dir=$(dirname $0) --target=$HOME/.config/atuin --restow atuin

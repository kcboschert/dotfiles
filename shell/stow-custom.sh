#!/usr/bin/env bash

mkdir -p $HOME/.config
stow --verbose --ignore='atuin/.*' --restow shell
stow --verbose --dir=$(dirname $0) --target=$HOME/.config/atuin --restow atuin

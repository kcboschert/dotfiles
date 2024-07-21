#!/usr/bin/env bash

mkdir -p $HOME/.config/atuin
stow --verbose --ignore='atuin.*' --ignore='starship.*' --restow shell
stow --verbose --dir=$(dirname $0) --target=${HOME}/.config/atuin --restow atuin
stow --verbose --dir=$(dirname $0) --target=${HOME}/.config --no-folding --restow starship

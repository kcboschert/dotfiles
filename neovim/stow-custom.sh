#!/usr/bin/env bash

mkdir -p $HOME/.config
stow --verbose --target=$HOME/.config --restow neovim

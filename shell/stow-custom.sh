#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

mkdir -p $HOME/.config/atuin
stow --verbose --target="${HOME}" --ignore='atuin.*' --ignore='starship.*' --restow shell
stow --verbose --dir=$(dirname $0) --target=${HOME}/.config/atuin --restow atuin
stow --verbose --dir=$(dirname $0) --target=${HOME}/.config/bottom --restow bottom
stow --verbose --dir=$(dirname $0) --target=${HOME}/.config --no-folding --restow starship

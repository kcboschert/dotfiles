#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

brew install \
  yazi \
  ffmpeg \
  sevenzip \
  jq \
  poppler \
  fd \
  ripgrep \
  fzf \
  zoxide \
  resvg \
  imagemagick

mkdir -p "$HOME"/.config

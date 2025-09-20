#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

install_zgenom() {
  if [ ! -d ${HOME}/.zgenom ]; then
    git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
  else
    pushd ${HOME}/.zgenom
    git pull
    popd
  fi
}

brew tap homebrew/command-not-found
brew install \
  bash \
  bottom \
  dust \
  eza \
  glow \
  gotop \
  gum \
  starship \
  vhs \
  zoxide \
  zsh

if ! command -v mise $ >/dev/null; then
  brew install mise
  mkdir -p /etc/bash_completion.d/
  mise completion bash >/etc/bash_completion.d/mise
fi

install_zgenom

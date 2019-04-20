#!/usr/bin/env bash

set -euo pipefail

# Install/Update zplug

if [ ! -d ${HOME}/.zplug ]; then
  git clone https://github.com/zplug/zplug.git "${HOME}/.zplug"
else
  pushd ${HOME}/.zplug
  git pull
  popd
fi

if [[ "$(uname)" == "Darwin" ]]; then
  if ! command -v gls >/dev/null 2>&1; then
    brew install coreutils
  fi
  for pkg in \
    font-fira-code-nerd-font \
    gnu-sed \
    gnu-tar \
    gnu-which \
    grep \
  ; do
    brew install ${pkg}
  done
fi

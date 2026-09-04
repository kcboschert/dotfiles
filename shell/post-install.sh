#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

install_cli_tools() {
  if [[ "$(uname)" == "Darwin" ]]; then
    brew install \
      coreutils \
      libyaml \
      gawk \
      gnu-sed \
      gnu-tar \
      gnu-which \
      gpg \
      grep
  elif [[ "$(uname)" == "Linux" ]]; then
    brew install acl
  fi
  mise use -g yq@latest
}

install_languages() {
  mise use -g dotnet@9
  mise use -g dotnet@10
  mise use -g lua@latest
  mise use -g go@latest
  mise use -g ruby@latest
  mise use -g node@latest
  mise use -g python@latest

  mise settings add idiomatic_version_file_enable_tools ruby
}

install_atuin() {
  if command -v atuin &>/dev/null; then
    echo "Atuin already installed!"
    return
  fi

  echo "Installing Atuin shell history manager..."
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
}

install_cli_tools
install_languages
install_atuin

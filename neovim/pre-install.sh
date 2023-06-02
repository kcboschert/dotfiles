#!/usr/bin/env bash

set -euo pipefail

function install_nvim_linux() {
  sudo apt-get install gcc g++ ripgrep

  curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
  tar xzvf nvim.tar.gz
  sudo cp -r nvim-linux64/* /usr/local
  rm -rf nvim-linux64 nvim.tar.gz
}

# needed for nvim-dap + jdtls
function install_java_debug() {
  if [[ ! -d ${HOME}/.java-debug ]]; then
    git clone https://github.com/microsoft/java-debug.git ${HOME}/.java-debug
  fi

  if [[ ! -d ${HOME}/.java-debug/com.microsoft.java.debug.plugin/target ]]; then
    pushd ${HOME}/.java-debug
    # handling older java default
    if [[ ${JAVA_HOME:-nope} == *"1.8.0"* ]]; then
      JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-17.0.4.jdk/Contents/Home ./mvnw clean install
    else
      ./mvnw clean install
    fi
    popd
  fi
}

if [[ "$(uname)" == "Darwin" ]]; then
  if [ -f ~/.nvm/nvm.sh ]; then
    brew install nvm
    . ~/.nvm/nvm.sh
  fi
  nvm install --lts

  brew install neovim ripgrep boost pybind11
elif [[ "$(uname)" == "Linux" ]]; then
  if ! command -v nvim $>/dev/null; then
    install_nvim_linux
  fi
  sudo apt-get install openjdk-17-jdk checkstyle
fi
install_java_debug

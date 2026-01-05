#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

source ./util.sh

install_llamacpp() {
  if [[ "$(uname)" == "Darwin" ]]; then
    echo "Installing llama.cpp via Homebrew..."
    brew install llama.cpp
  elif [[ "$(uname)" == "Linux" ]]; then
    install_llamacpp_vulkan
  fi
}

install_llamacpp_vulkan() {
  curl -s https://api.github.com/repos/ggml-org/llama.cpp/releases/latest | jq -r '.assets[] | select(.browser_download_url | contains("bin-ubuntu-vulkan-x64.zip")) | .browser_download_url' | xargs curl -Lo llamacpp.zip
  temp_dir=$(mktemp -d)
  trap 'rm -rf $temp_dir' EXIT
  unzip llamacpp.zip -d "${temp_dir}"
  sudo cp -r "${temp_dir}"/build/bin/* /usr/local/bin/
  rm -rf "${temp_dir}" llamacpp.zip
}

install_llamacpp_cuda() {
  sudo apt install libcurl4-openssl-dev
  temp_dir=$(mktemp -d)
  git clone https://github.com/ggml-org/llama.cpp "$temp_dir"
  trap 'rm -rf $temp_dir' EXIT

  pushd "$temp_dir"
  # TODO: don't hardcode this path
  CUDACXX=/usr/local/cuda-12.8/bin/nvcc cmake -B build -DGGML_CUDA=ON -DLLAMA_CURL=ON # -DGGML_VULKAN=ON
  cmake --build build --config Release
  sudo cp -r "$temp_dir/build/bin/"* /usr/local/bin/
}

if ! command -v aider &>/dev/null; then
  echo "aider could not be found, installing..."
  python -m pip install aider-install
  aider-install
fi

if ! command -v ollama &>/dev/null; then
  if prompt "\nollama not found. Install?"; then
    echo "Installing ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
  else
    echo "ollama installation skipped."
  fi
fi

brew install opencode

install_llamacpp

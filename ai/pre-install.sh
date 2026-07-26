#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

source ./util.sh

install_llamacpp() {
  if ! command -v nvidia-smi &>/dev/null; then
    echo "Installing/Updating llama.cpp via Homebrew..."
    brew install llama.cpp
  else
    if command -v llama-server &>/dev/null; then
      if prompt "llama-server is already installed. Reinstall/Update?"; then
        install_llamacpp_cuda
      else
        echo "llama-server installation skipped."
      fi
    fi
  fi
}

install_llamacpp_vulkan() {
  curl -s https://api.github.com/repos/ggml-org/llama.cpp/releases/latest | jq -r '.assets[] | select(.browser_download_url | contains("bin-ubuntu-vulkan-x64.tar.gz")) | .browser_download_url' | xargs curl -Lo llamacpp.tar.gz
  temp_dir=$(mktemp -d)
  trap 'rm -rf $temp_dir' EXIT
  tar -vxzf llamacpp.tar.gz -C "${temp_dir}"
  sudo cp -r "${temp_dir}"/llama-*/llama-* /usr/local/bin/
  rm -rf "${temp_dir}" llamacpp.tar.gz
}

install_llamacpp_cuda() {
  sudo apt install libcurl4-openssl-dev
  temp_dir=$(mktemp -d)
  git clone https://github.com/ggml-org/llama.cpp "$temp_dir"
  trap 'rm -rf $temp_dir' EXIT

  pushd "$temp_dir"
  CUDACXX=/usr/local/cuda/bin/nvcc cmake -B build -DBUILD_SHARED_LIBS=OFF -DGGML_CUDA=ON # -DGGML_VULKAN=ON
  cmake --build build --config Release -j --clean-first --target llama-cli llama-mtmd-cli llama-server llama-gguf-split
  sudo cp "$temp_dir"/build/bin/llama-* /usr/local/bin/
}

if ! command -v aider &>/dev/null; then
  echo "aider could not be found, installing..."
  python -m pip install aider-install
  aider-install
fi

if ! command -v ollama &>/dev/null; then
  if prompt "ollama not found. Install?"; then
    echo "Installing ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
  else
    printf "\nollama installation skipped."
  fi
fi

mise use -g opencode
mise use -g pi
mise use -g rtk

install_llamacpp
brew install openai-whisper

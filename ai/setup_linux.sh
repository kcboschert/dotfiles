#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

install_llamacpp() {
  if ! command -v nvidia-smi &>/dev/null; then
    echo "Installing/Updating llama.cpp via Homebrew..."
    brew install llama.cpp
  else
    if ! command -v llama-server &>/dev/null; then
      install_llamacpp_cuda
    fi
  fi
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

if [[ "$(uname)" == "Linux" ]]; then
  install_llamacpp
fi

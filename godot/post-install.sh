#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

if ! command -v godot &>/dev/null; then
  if [[ "$(uname)" == "Linux" ]]; then
    "$(dirname "$0")/.bin/update-godot" || true
  elif [[ "$(uname)" == "Darwin" ]]; then
    brew install godot-mono
  fi
fi

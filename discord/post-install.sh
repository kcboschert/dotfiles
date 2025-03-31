#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

if [[ "$(uname)" == "Linux" ]]; then
  "$(dirname "$1")/.bin/update-discord"
fi

#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname)" == "Darwin" ]]; then
  for pkg in ctags jq ; do
    if ! command -v ${pkg} >/dev/null 2>&1; then
      brew install ${pkg}
    fi
  done

  if ! command -v mvnd >/dev/null 2>&1; then
    brew install mvndaemon/homebrew-mvnd/mvnd
  fi
fi

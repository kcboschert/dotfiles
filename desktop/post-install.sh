#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname)" == "Darwin" ]]; then
  for pkg in \
    dozer \
    meetingbar \
  ; do
    brew install ${pkg}
  done
fi

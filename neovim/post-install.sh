#!/usr/bin/env bash

set -euo pipefail

for pkg in ctags jq; do
	brew install ${pkg}
done

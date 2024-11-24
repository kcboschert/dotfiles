#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

if [[ "$(uname)" == "Darwin" ]]; then
	for pkg in \
		dozer \
		meetingbar; do
		brew install ${pkg}
	done
fi

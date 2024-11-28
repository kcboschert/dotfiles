#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

"$(dirname "$0")/.bin/update_discord"

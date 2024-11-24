#!/usr/bin/env bash

set -o nounset -o pipefail -o errexit

${HOME}/.tmux/plugins/tpm/scripts/clean_plugins.sh
${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh
${HOME}/.tmux/plugins/tpm/scripts/update_plugin.sh

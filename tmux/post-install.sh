#!/usr/bin/env bash

set -euo pipefail

${HOME}/.tmux/plugins/tpm/scripts/clean_plugins.sh
${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh
${HOME}/.tmux/plugins/tpm/scripts/update_plugin.sh

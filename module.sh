#!/usr/bin/env bash

set -euo pipefail

# Ensure MISE_PROJECT_ROOT is set
if [[ -z "${MISE_PROJECT_ROOT:-}" ]]; then
  echo "Error: MISE_PROJECT_ROOT is not set. Please run from the repository root." >&2
  exit 1
fi

CONF_DIR="$HOME/.config/mise/conf.d"
mkdir -p "$CONF_DIR"

activate_all() {
  for dir in "$MISE_PROJECT_ROOT"/*/; do
    [ -f "${dir}mise.toml" ] || continue
    name=$(basename "$dir")
    activate "${name}"
  done
}

module_paths() {
  local module="$1"
  local -n src_out="$2"
  local -n dst_out="$3"
  src_out="$MISE_PROJECT_ROOT/$module/mise.toml"
  dst_out="$CONF_DIR/$module.toml"
}

activate() {
  local module="$1"
  if [[ -z "${module:-}" ]]; then
    echo "Error: Module name required for activate." >&2
    exit 1
  fi
  local src dst
  module_paths "$module" src dst

  [[ -f "$src" ]] || {
    echo "error: no mise.toml at $src" >&2
    exit 1
  }
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  echo "activated: $src -> $dst"
}

deactivate() {
  local module="$1"
  if [[ -z "${module:-}" ]]; then
    echo "Error: Module name required for deactivate." >&2
    exit 1
  fi
  local src dst
  module_paths "$module" src dst

  if [ -L "${dst}" ]; then
    rm "${dst}"
    echo "Deactivated ${module}: removed ${dst}"
  elif [ -e "${dst}" ]; then
    echo "Cannot deactivate ${module}: ${dst} exists but is not a symlink" >&2
    exit 1
  else
    echo "${module} already inactive"
  fi
}

deactivate_all() {
  for dst in "$CONF_DIR"/*.toml; do
    [ -L "$dst" ] || continue
    case "$(readlink "$dst")" in
    "$MISE_PROJECT_ROOT"/*)
      module=$(basename "${dst}" .toml)
      deactivate "${module}"
      ;;
    esac
  done
}

status() {
  local active=() inactive=()
  for dir in "$MISE_PROJECT_ROOT"/*/; do
    [ -f "${dir}mise.toml" ] || continue
    local module
    module=$(basename "$dir")
    local src dst
    module_paths "$module" src dst

    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
      active+=("$module")
    else
      inactive+=("$module")
    fi
  done

  local green=$'\033[32m' red=$'\033[31m' reset=$'\033[0m'
  printf "\n%sActive:%s\n" "${green}" "${reset}"
  printf '  %s\n' "${active[@]}"
  printf "\n%sInactive:%s\n" "${red}" "${reset}"
  printf '  %s\n' "${inactive[@]}"
}

case "${1:-}" in
activate_all)
  activate_all
  mise bootstrap
  ;;
activate)
  activate "${2:-}"
  mise bootstrap
  ;;
deactivate)
  deactivate "${2:-}"
  ;;
deactivate_all)
  deactivate_all
  ;;
status)
  status
  ;;
*)
  echo "Usage: $0 {activate|deactivate|activate_all|deactivate_all|status} [module]"
  exit 1
  ;;
esac

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

activate() {
  local module="$1"
  if [[ -z "${module:-}" ]]; then
    echo "Error: Module name required for activate." >&2
    exit 1
  fi
  local src="$MISE_PROJECT_ROOT/$module/mise.toml"
  local dst="$CONF_DIR/$module.toml"

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
  local dst="$CONF_DIR/$module.toml"

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
*)
  echo "Usage: $0 {activate|deactivate|activate_all|deactivate_all} [module]"
  exit 1
  ;;
esac

#!/usr/bin/env bash

prompt() {
  local message=$1
  while true; do
    echo ""
    read -p "${message} [y/n]" -n 1 -r yn

    case $yn in
    [Yy])
      echo ""
      return 0
      ;;
    [Nn])
      echo ""
      return 1
      ;;
    *) printf "\nInvalid response. Please answer with 'y' or 'n'." ;;
    esac
  done
}

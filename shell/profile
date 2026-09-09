# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

if [ -d "$HOME/go" ]; then
  export GOPATH="$HOME/go"
fi

# optional PATHs
if [ -d "$HOME/.bin" ]; then
  export PATH="$PATH:$HOME/.bin"
fi
if [ -d "$HOME/.local/bin" ]; then
  export PATH=$PATH:"$HOME/.local/bin"
fi
if [ -d "$GOPATH/bin" ]; then
  export PATH=$PATH:"$GOPATH/bin"
fi

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME"/.cargo/env
fi

# local customizations
if [ -f "$HOME/.profile.local" ]; then
  . "$HOME"/.profile.local
fi

if [ -f "$HOME/.aliases.local" ]; then
  . "$HOME"/.aliases.local
fi

# Homebrew
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export HOMEBREW_NO_ENV_HINTS=true
fi

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH=/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/gnu-which/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
  HOMEBREW_COMMAND_NOT_FOUND_HANDLER="$(brew --repository)/Library/Homebrew/command-not-found/handler.sh"
  if [ -f "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER" ]; then
    source "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER"
  fi
fi

if which godot >/dev/null 2>&1; then
  export GODOT_BIN=$(which godot)
fi

if which ollama >/dev/null 2>&1; then
  export OLLAMA_API_BASE=http://127.0.0.1:11434
fi

export DO_NOT_TRACK=1
export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=true

export EDITOR=nvim

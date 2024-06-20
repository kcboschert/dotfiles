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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.bin" ]; then
	PATH="$HOME/.bin:$PATH"
fi

if [ -f "$HOME/.profile.local" ]; then
	source $HOME/.profile.local
fi

if [ -f "$HOME/.aliases.local" ]; then
	source $HOME/.aliases.local
fi

if [[ "$(uname)" == "Darwin" ]]; then
	export PATH=/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/gnu-which/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
fi

export GOPATH="$HOME/go"
export CARGO_HOME="$HOME/.cargo"
export PATH=$PATH:"$GOPATH/bin:$CARGO_HOME/bin:$HOME/.local/bin:$HOME/bin"
export EDITOR=nvim

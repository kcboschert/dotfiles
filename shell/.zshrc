# Uncomment this line and the last `zprof` line to run a profiler on startup
# zmodload zsh/zprof

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

. "$HOME/.atuin/bin/env"
source "${HOME}/.zgenom/zgenom.zsh"

zgenom autoupdate
# if the init script doesn't exist
if ! zgenom saved; then
	zgenom ohmyzsh

	zgenom ohmyzsh plugins/command-not-found
	zgenom ohmyzsh plugins/colored-man-pages

	zgenom load zsh-users/zsh-syntax-highlighting
	zgenom load zsh-users/zsh-completions
	zgenom load zsh-users/zsh-autosuggestions

	zgenom load atuinsh/atuin

	# generate the init script from plugins above
	zgenom save
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5"

source ~/.aliases
if [[ "$(uname)" == "Darwin" ]]; then
  alias ctags="`brew --prefix`/bin/ctags"
  export PATH="/usr/local/sbin:$PATH"
fi

bindkey -v
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^[[1;3C" forward-word    # Alt+Right
bindkey "^[[1;3D" backward-word   # Alt+Left
bindkey "\e[3~" delete-char       # Delete

if [ -f "$HOME/.env.local" ]; then
  source $HOME/.env.local
fi

eval "$(starship init zsh)"
eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"

# zsh completions

autoload -Uz compinit
compinit

# Uncomment this line and the top `zmodload zsh/zprof` line to run a profiler on startup
# zprof

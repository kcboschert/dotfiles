# Uncomment this line and the last `zprof` line to run a profiler on startup
# zmodload zsh/zprof

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
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
  alias ls='gls --color=auto'
  alias ctags="`brew --prefix`/bin/ctags"
  eval `gdircolors $HOME/.dircolors`
  export PATH="/usr/local/sbin:$PATH"
elif [[ "$(uname)" == "Linux" ]]; then
  eval `dircolors $HOME/.dircolors`
  alias ls='ls --color=auto'
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

eval "$(atuin init zsh)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"

# Uncomment this line and the top `zmodload zsh/zprof` line to run a profiler on startup
# zprof

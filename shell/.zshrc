# Uncomment this line and the last `zprof` line to run a profiler on startup
# zmodload zsh/zprof

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
source "${HOME}/.zplug/init.zsh"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh

if [ -d "$HOME/.asdf" ]; then
  export ASDF_GOLANG_MOD_VERSION_ENABLED=false
  zplug "plugins/asdf", from:oh-my-zsh
fi

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

zplug "atuinsh/atuin"

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

zplug load

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

# Uncomment this line and the top `zmodload zsh/zprof` line to run a profiler on startup
# zprof

# Uncomment this line and the last `zprof` line to run a profiler on startup
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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


zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme

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

eval "$(atuin init zsh)"

bindkey -v
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^[[1;3C" forward-word    # Alt+Right
bindkey "^[[1;3D" backward-word   # Alt+Left

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -f "$HOME/.env.local" ]; then
  source $HOME/.env.local
fi

# Uncomment this line and the top `zmodload zsh/zprof` line to run a profiler on startup
# zprof

# To customize prompt, run `p10k configure` or edit ~/git/dotfiles/shell/.p10k.zsh.
[[ ! -f ~/git/dotfiles/shell/.p10k.zsh ]] || source ~/git/dotfiles/shell/.p10k.zsh

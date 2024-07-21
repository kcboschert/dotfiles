if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH=/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/gnu-which/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
elif [[ "$(uname)" == "Linux" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

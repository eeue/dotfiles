# Important Settings idk

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# Smexy Coompletionz

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

autoload -Uz compinit

compinit

# Adding to $PATH

source $HOME/.cargo/env

# export to sub-processes (make it inherited by child processes)

export PATH

# Smexy Prompt :o

eval "$(starship init zsh)"


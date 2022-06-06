# sexy completion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
autoload -U colors && colors
autoload -Uz compinit
compinit

# history settings and emacs binding
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# fish-like autosuggestion, very cool
source ~/zplugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# fish-like syntax highlighting, also cool
source ~/zplugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# swaggy prompt
eval "$(starship init zsh)"


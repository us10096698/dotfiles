#!/usr/bin/env bash

case ${OSTYPE} in
  darwin*)
    alias ls='gls --color=auto'
    eval $(gdircolors ~/.dir_colors)
    ;;
  cygwin*)
    alias open='cygstart'
    alias pbcopy='cat > /dev/clipboard'
    alias pbpaste='cat /dev/clipboard'
    alias ls='ls --color=auto'
    ;;
  *)
    alias ls='ls --color=auto'
    alias pbpaste='xsel -b'
    alias pbcopy='xsel -b'
    ;;
esac

alias vi=vim
alias ll='ls -l'
alias lla='ls -la'

alias tmux='tmux -2'

# eval "$(docker-machine env default)"

# export PATH=$HOME/.nodebrew/current/bin:$PATH
# export PATH="$HOME/.rbenv/bin:$PATH"

# eval "$(rbenv init -)"

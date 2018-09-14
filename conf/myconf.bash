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
    alias pbcopy='xsel -bi'
    alias pbpaste='xsel -bo'
    ;;
esac

alias vi=vim
alias ll='ls -l'
alias lla='ls -la'

alias tmux='tmux -2'
alias pip='pip --trusted-host pypi.python.org'

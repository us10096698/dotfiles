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

if command -v nvim >/dev/null 2>&1; then
    alias vi=nvim
    alias vim=nvim
else
    alias vi=vim
fi

alias ll='ls -l'
alias lla='ls -la'

alias tmux='tmux -2'
alias pip='pip --trusted-host pypi.python.org'
alias tree="pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/| /g'"
alias rmxcodecache="rm -rf ~/Library/Developer/XCode/DerivedData/*"

export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

export RBENV_ROOT=$HOME/.rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

eval "$(nodenv init -)"

export PATH=$PATH:$HOME/bullpen/devtools/flutter/bin

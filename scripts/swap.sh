#! /bin/sh

set -eux

if [ $# -ne 1 ]; then
  echo "USAGE: swap.sh <DOTFILES_DIR>"
  exit 1
fi

dotfilesdir="$1"

[ -d "$dotfilesdir" ]

cd ~

[ -f "$dotfilesdir"/.bash_profile ] && ln -nfs "$dotfilesdir"/.bash_profile .bash_profile || :
[ -d "$dotfilesdir"/.bash_it ] && ln -nfs "$dotfilesdir"/.bash_it .bash_it || :
[ -d "$dotfilesdir"/.vim ] && ln -nfs "$dotfilesdir"/.vim .vim || :
[ -f "$dotfilesdir"/.vimrc ] && ln -nfs "$dotfilesdir"/.vimrc .vimrc || :
[ -f "$dotfilesdir"/.gvimrc ] && ln -nfs "$dotfilesdir"/.gvimrc .gvimrc || :
[ -f "$dotfilesdir"/.tmux.conf ] && ln -nfs "$dotfilesdir"/.tmux.conf .tmux.conf || :
[ -f "$dotfilesdir"/.dircolors ] && ln -nfs "$dotfilesdir"/.dircolors .dircolors || :
[ -f "$dotfilesdir"/.gitconfig ] && ln -nfs "$dotfilesdir"/.gitconfig .gitconfig || :


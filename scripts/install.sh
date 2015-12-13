#! /bin/sh

set -eux

if [ $# -ne 1 ]; then
  echo "USAGE: install.sh <BACKUP_DIR>"
  exit 1
fi

cd ~/.dotfiles

git submodule init
git submodule update

backupdir="$1" 

# backup
[ -f ~/.bash_profile ] && mv ~/.bash_profile "$backupdir"/.bash_profile || :
[ -d ~/.bash_it ] && mv ~/.bash_it "$backupdir"/.bash_it || :
[ -d ~/.vim ] && mv ~/.vim "$backupdir"/.vim || :
[ -f ~/.vimrc ] && mv ~/.vimrc "$backupdir"/.vimrc || :
[ -f ~/.gvimrc ] && mv ~/.gvimrc "$backupdir"/.gvimrc || :
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf "$backupdir"/.tmux.conf || :
[ -f ~/.dircolors ] && mv ~/.dircolors "$backupdir"/.dircolors || :
[ -f ~/.gitconfig ] && mv ~/.gitconfig "$backupdir"/.gitconfig || :

rm -rf .bash_it/custom
ln -s ~/.dotfiles/custom .bash_it/custom

cd ~
ln -s .dotfiles/.bash_it .bash_it
ln -s .dotfiles/.vim .vim
ln -s .dotfiles/.vimrc .vimrc
ln -s .dotfiles/.gvimrc .gvimrc
ln -s .dotfiles/.tmux.conf .tmux.conf
ln -s .dotfiles/.gitconfig .gitconfig
ln -s .dotfiles/.dircolors .dircolors

sh .bash_it/install.sh

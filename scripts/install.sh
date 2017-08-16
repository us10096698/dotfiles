#! /bin/sh

set -eux

cd ~/.dotfiles

git submodule init
git submodule update

backupdir="~/.dotfiles.backup"

[ -d $backupdir ] && : || mkdir -p $backupdir

# backup
[ -f ~/.bash_profile ] && mv ~/.bash_profile "$backupdir"/.bash_profile || :
[ -d ~/.bash_it ] && mv ~/.bash_it "$backupdir"/.bash_it || :
[ -f ~/.vimrc ] && mv ~/.vimrc "$backupdir"/.vimrc || :
[ -f ~/.gvimrc ] && mv ~/.gvimrc "$backupdir"/.gvimrc || :
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf "$backupdir"/.tmux.conf || :
[ -f ~/.dir_colors ] && mv ~/.dir_colors "$backupdir"/.dir_colors || :
[ -f ~/.gitconfig ] && mv ~/.gitconfig "$backupdir"/.gitconfig || :

echo "NOTICE: Original dotfiles are copied into ~/.dotfiles.backup directory."

rm -rf .bash_it/custom
ln -s ~/.dotfiles/custom .bash_it/custom

cd ~
ln -s .dotfiles/.bash_it .bash_it
ln -s .dotfiles/.vimrc .vimrc
ln -s .dotfiles/.gvimrc .gvimrc
ln -s .dotfiles/.tmux.conf .tmux.conf
ln -s .dotfiles/.gitconfig .gitconfig
ln -s .dotfiles/.dircolors .dircolors

sh .bash_it/install.sh

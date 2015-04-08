#! /bin/sh

cd ~/.dotfiles

git submodule init
git submodule update

echo '* Backing up old files'

if [ -d ~/.vim ]; then
  mv ~/.vim ~/.vim.org
fi

if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.org
fi

if [ -f ~/.gvimrc ]; then
  mv ~/.gvimrc ~/.gvimrc.org
fi

if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig ~/.gitconfig.org
fi

echo '* Creating symbolic links'

cd ~
ln -s .dotfiles/.vim .vim
ln -s .dotfiles/.vimrc .vimrc
ln -s .dotfiles/.gvimrc .gvimrc
ln -s .dotfiles/.gitconfig .gitconfig

echo '* Creating .vimbackup dir'
mkdir ~/.vimbackup

echo '* All dotfiles were installed correctly.'

#! /bin/sh

cd ~/.dotfiles

git submodule init
git submodule update
cp custom/* .bash_it/custom/.

if [ -d ~/.bash_it ]; then
  mv ~/.bash_it ~/.bash_it.bak
fi

if [ -d ~/.vim ]; then
  mv ~/.vim ~/.vim.bak
fi

if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.bak
fi

if [ -f ~/.gvimrc ]; then
  mv ~/.gvimrc ~/.gvimrc.bak
fi

if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig ~/.gitconfig.bak
fi

cd ~
ln -s .dotfiles/.bash_it .bash_it
ln -s .dotfiles/.vim .vim
ln -s .dotfiles/.vimrc .vimrc
ln -s .dotfiles/.gvimrc .gvimrc
ln -s .dotfiles/.gitconfig .gitconfig

mkdir ~/.vimbackup
sh .bash_it/install.sh


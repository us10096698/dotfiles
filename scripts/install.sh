#! /bin/sh

cd ~/.dotfiles

git submodule init
git submodule update

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

if [ -d ~/.tmux.conf ]; then
  mv ~/.tmux.conf ~/.tmux.conf.bak
fi

if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig ~/.gitconfig.bak
fi

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

mkdir ~/.vimbackup
sh .bash_it/install.sh

dotfiles
========

## About
This repository includes my dotfiles.

## Requirements
The stuff of this repository needs some plugins below.

+ [curl and libcurl](http://curl.haxx.se/)

## Quick Start

- Clone the repo via: `$ git clone https://github.com/us10096698/dotfiles`

- Initialize the repo
  
  ```
  $ git submodule init
  $ git submodule update
  ```

- Create the symbolic links into your home directory.

  + Mac / Linux environment:

  ```
  $ cd ~
  $ ln -s path/to/repository/dotfiles/.vim .vim
  $ ln -s path/to/repository/dotfiles/.vimrc .vimrc
  $ ln -s path/to/repository/dotfiles/.gvimrc .gvimrc
  $ ln -s path/to/repository/dotfiles/.gitconfig .gitconfig
  ```
  + Windows(cmd) environment:

  ```
  > cd ~
  > mklink /d .vim /path/to/repository/dotfiles/.vim
  > mklink .vimrc /path/to/repository/dotfiles/.vimrc
  > mklink .gvimrc /path/to/repository/dotfiles/.gvimrc
  > mklink .gitconfig /path/to/repository/dotfiles/.gitconfig
  ```

- Create the vim backup directory: `$ mkdir ~/.vimbackup`
- (Optional) Create local git configuration file: `~/.gitconfig.local`

## Commands
+ Markdown preview (Blowser): `Ctrl`+`P`
  * [Ref](http://dackdive.hateblo.jp/entry/2014/09/11/213455)
+ Foldings
  * Open folding under cursor: `zo`
  * Open all foldings: `zO`
  * Close folding under cursor : `zc`
  * Clone all foldings: `zC`


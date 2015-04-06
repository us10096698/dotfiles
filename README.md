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

  + Linux environment:

  ```
  $ cd ~
  $ ln -s path/to/repository/dotfiles/.vimrc .vimrc
  $ ln -s path/to/repository/dotfiles/.gvimrc .gvimrc
  $ ln -s path/to/repository/dotfiles/.gitconfig .gitconfig
  ```
  + Windows(cmd) environment:

  ```
  > cd ~
  > mklink .vimrc /path/to/repository/dotfiles/.vimrc
  > mklink .gvimrc /path/to/repository/dotfiles/.gvimrc
  > mklink /d .vim /path/to/repository/dotfiles/.vim
  > mklink .vimrc /path/to/repository/dotfiles/.vimrc .vimrc
  ```

- Create the vim backup directory via: `$ mkdir ~/.vimbackup`
- (Optional) You can set your local git configuration into `~/.gitconfig.local` file.

## Commands
### Markdown Preview (Blowser): `\r`
  + Prerequisites: [Configure vimproc](https://github.com/Shougo/vimproc.vim) 
  + __NOTE:__ This feature is tested with kaoriya-gvim-win64 and MacVim
  + __CAUTION:__ Currently, this configuration not works correctly in cygwin-vim environment 

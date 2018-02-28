#!/bin/bash

cd ~/workspace/hirabara/vim/src

make distclean

./configure \
  --with-features=huge \
  --enable-fail-if-missing \
  --enable-luainterp=yes\
  --enable-perlinterp=yes \
  --enable-python3interp=yes \
  --enable-rubyinterp=dynamic \
  --enable-multibyte \
  --enable-cscope \
  --enable-fontset \
  --prefix=/opt \
  --with-lua-prefix=/usr/local

make

# sudo -E make install


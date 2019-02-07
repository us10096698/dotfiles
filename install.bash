#!/bin/bash

# set -eux

echo "## variables"

IS_INSECURE=false

DOTFILES_HOME="$HOME/.dotfiles"
BASH_PROFILE="$HOME/.bash_profile"

DATE=$(date +%Y%m%d%H%M%S)
BACKUPDIR="$HOME/.dotfiles.backup.$DATE"

IS_CYG="uname | grep CYG"
DIST=$(awk -F'=' '/^NAME/{print $2}' /etc/os-release)
[ "$DIST" = "CentOS Linux" ]; IS_CENTOS=true
[ "$DIST" = "Ubuntu" ]; IS_UBUNTU=false

echo "- IS_INSECURE: $IS_INSECURE"
echo "- BACKUPDIR: $BACKUPDIR"
echo "- DIST: $DIST"

NODE_VERSION="8.3.0"
RUBY_VERSION="2.5.3"
PYTHON_VERSION="anaconda3-5.1.0"

echo "## commands"

backup_and_link() {
  echo "***** backup_and_link *****"

  [ `eval $IS_CYG` ] && export CYGWIN=winsymlinks:native || :

  cd $HOME
  mkdir -p $BACKUPDIR

  [ -f $BASH_PROFILE ] && mv $BASH_PROFILE $BACKUPDIR || :

  for f in $(find $DOTFILES_HOME/symlinks -maxdepth 1 -name '.*')
  do
    NAME=$(basename $f)
    echo $NAME
    [ -f $f ] && echo "-- backup[f]: $f" && mv $HOME/$NAME $BACKUPDIR || :
    [ -d $f ] && echo "-- backup[d]: $f" && mv $HOME/$NAME $BACKUPDIR || :
    ln -s $f && echo "-- symlink: $f"
  done

  [ -d $HOME/.jupyter ] && mv $HOME/.jupyter $BACKUPDIR/.jupyter || :
  cp -r $DOTFILES_HOME/.jupyter $HOME/.

  [ $IS_INSECURE ] && echo 'insecure' >> $HOME/.curlrc

  echo "source $DOTFILES_HOME/conf/myconf.bash" >> $BASH_PROFILE #alias

  cd $DOTFILES_HOME
}

install_dependency() {
  echo "***** install_dependency *****"

  case ${OSTYPE} in
    darwin*)
      /usr/bin/ruby -e "$(curl -kfsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      brew tap pivotal/tap
      brew tap caskroom/cask
      brew tap caskroom/versions
      brew install $(<osx/packages.txt)
      brew cask install $(<osx/packages-cask.txt)
      ;;
    cygwin*)
      ;;
    linux-gnu*)
      if [ $IS_CENTOS ]; then
        sudo -E yum install -y automake libevent-devel ncurses-devel #tmux
        sudo yum install -y openssl-devel readline-devel zlib-devel #ruby
        sudo yum install -y lua-devel ncurses-devel python-devel perl-ExtUtils-Embed the_silver_searcher #vim
      elif [ $IS_UBUNTU ]; then
        sudo -E ufw disable
        sudo -E apt install -y language-pack-ja-base language-pack-ja fonts-ipafont-gothic fonts-ipafont-mincho
        sudo -E apt install -y gcc
        sudo -E apt install -y pkg-config automake libevent-dev libncurses5-dev xsel #tmux
        sudo -E apt install -y libssl-dev libreadline-dev #ruby
        sudo -E apt build-dep -y lua5.2 lua5.2-dev libperl-dev python-dev python3-dev libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev vim #vim
        sudo -E apt intall -y zsh
      fi
      ;;
    *)
      ;;
  esac
}

install_tmux() {
  echo "***** install_tmux *****"
  [ `eval $IS_CYG` ] && return || :
  if [ -f /usr/local/bin/tmux ]; then echo 'tmux has already installed. skipping..'; return; fi

  cd $DOTFILES_HOME/submodule/tmux
  git checkout $(git tag | sort -V | tail -n 1)
  ./autogen.sh
  ./configure
  make
  sudo -E make install
  echo 'source $HOME/.bashrc' >> $BASH_PROFILE
}

install_ruby() {
  echo "***** install_ruby *****"
  [ `eval $IS_CYG` ] && return || :
  if type rbenv > /dev/null 2>&1; then echo 'rbenv has already installed. skipping..'; return ; fi

  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $BASH_PROFILE
  echo 'eval "$(rbenv init -)"' >> $BASH_PROFILE

  mkdir -p $HOME/.rbenv/plugins
  git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  source $BASH_PROFILE

  if [ $IS_INSECURE ]; then
    RUBY_BUILD_CURL_OPTS=--insecure rbenv install $RUBY_VERSION
    echo ':ssl_verify_mode: 0' >> ~/.gemrc;
  else
    rbenv install $RUBY_VERSION
  fi

  rbenv global $RUBY_VERSION
}

install_python() {
  echo "***** install_python *****"
  [ `eval $IS_CYG` ] && return || :
  if type pyenv > /dev/null 2>&1; then echo 'pyenv has already installed. skipping..'; return; fi

  git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
  echo 'export PYENV_ROOT'="$HOME/.pyenv" >> $BASH_PROFILE
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $BASH_PROFILE
  echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> $BASH_PROFILE
  # echo 'eval "$(pyenv virtualenv-init -)"' >> $BASH_PROFILE
  source $BASH_PROFILE

  CONFIGURE_OPTS="--enable-shared" pyenv install $PYTHON_VERSION
  pyenv global $PYTHON_VERSION

  if [ $IS_INSECURE ]; then conda config --set ssl_verify False; fi

  PASSWORD_HASH=`python $HOME/.jupyter/passwd.py`
  echo "c.NotebookApp.password = u'$PASSWORD_HASH'" >> $HOME/.jupyter/jupyter_notebook_config.py

  STARTUP_DIR=".ipython/profile_default/startup"
  [ ! -d $HOME/$STARTUP_DIR ]; mkdir -p $HOME/$STARTUP_DIR
  cd $DOTFILES_HOME/$STARTUP_DIR && ls *.ipy | xargs -I{} ln -s $DOTFILES_HOME/$STARTUP_DIR/{} $HOME/$STARTUP_DIR/{}
}

install_vim() {
  VIMPATH="$HOME/opt"

  [ `eval $IS_CYG` ] && return || :

  cd $DOTFILES_HOME/submodule/vim/src
  make distclean

  case ${OSTYPE} in
    darwin*)
      ./configure \
        --with-features=huge \
        --enable-fail-if-missing \
        --enable-luainterp=yes\
        --enable-perlinterp=yes \
        --enable-rubyinterp=dynamic \
        --enable-multibyte \
        --enable-python3interp=yes \
        --enable-cscope \
        --enable-fontset \
        --prefix=$VIMPATH \
        --with-lua-prefix=/usr/local
      ;;
    linux-gnu*)
      ## because of linker error, excluded lto by LDFLAGS
      LDFLAGS="-fno-lto" \
      ./configure \
        --with-features=huge \
        --enable-fail-if-missing \
        --disable-selinux \
        --enable-luainterp \
        --enable-perlinterp \
        --enable-pythoninterp \
        --enable-python3interp \
        --enable-rubyinterp=dynamic \
        --enable-cscope \
        --enable-fontset \
        --enable-multibyte \
        --with-ruby-command=$(which ruby) \
        --prefix=$VIMPATH
      ;;
    *)
      ;;
  esac
  make && make install
}

cd $DOTFILES_HOME

# backup_and_link
# install_dependency
# install_tmux
# install_ruby
# install_python
# install_vim

echo "DONE!"


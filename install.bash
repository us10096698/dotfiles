#!/bin/bash

# set -eux

DOTFILES_HOME="$HOME/.dotfiles"
BACKUPDIR="$HOME/.dotfiles.backup"
IS_CYG="uname | grep CYG"
IS_INSECURE=true

backup() {
  [ -f $HOME/.bash_profile ] && mv $HOME/.bash_profile "$BACKUPDIR"/.bash_profile || :
  [ -f $HOME/.vimrc ] && mv $HOME/.vimrc "$BACKUPDIR"/.vimrc || :
  [ -f $HOME/.gvimrc ] && mv $HOME/.gvimrc "$BACKUPDIR"/.gvimrc || :
  [ -f $HOME/.tmux.conf ] && mv $HOME/.tmux.conf "$BACKUPDIR"/.tmux.conf || :
  [ -f $HOME/.dir_colors ] && mv $HOME/.dir_colors "$BACKUPDIR"/.dir_colors || :
  [ -f $HOME/.gitconfig ] && mv $HOME/.gitconfig "$BACKUPDIR"/.gitconfig || :
  [ -d $HOME/.snip ] && mv $HOME/.snip $BACKUPDIR/.snip || :
  [ -d $HOME/.jupyter ] && mv $HOME/.jupyter $BACKUPDIR/.jupyter || :
}

common() {
  [ `eval $IS_CYG` ] && export CYGWIN=winsymlinks:native || :

  ln -s $DOTFILES_HOME/.vimrc $HOME/.vimrc
  ln -s $DOTFILES_HOME/.gvimrc $HOME/.gvimrc
  ln -s $DOTFILES_HOME/.tmux.conf $HOME/.tmux.conf
  ln -s $DOTFILES_HOME/.gitconfig $HOME/.gitconfig
  ln -s $DOTFILES_HOME/.dir_colors $HOME/.dir_colors
  ln -s $DOTFILES_HOME/.snip $HOME/.snip
  cp -r $DOTFILES_HOME/.jupyter $HOME/.

  [ -d $HOME/.vim ] && : || mkdir $HOME/.vim
  ln -s $DOTFILES_HOME/rc $HOME/.vim/rc

  echo "source $DOTFILES_HOME/custom/myconf.bash" >> $HOME/.bash_profile #alias
}

install_dependency() {
  case ${OSTYPE} in
    darwin*)
      ;;
    cygwin*)
      ;;
    linux-gnu*)
      sudo -E ufw disable

      sudo -E apt install -y language-pack-ja-base language-pack-ja fonts-ipafont-gothic fonts-ipafont-mincho
      sudo -E apt install -y gcc
      # http://blog.amedama.jp/entry/2016/11/30/155238
      sudo -E apt install -y xserver-xorg xvfb sysv-rc-conf #xvfb
      sudo -E apt install -y pkg-config automake libevent-dev libncurses5-dev xsel #tmux
      sudo -E apt install -y libssl-dev libreadline-dev #rbenv
      # https://stackoverflow.com/questions/11416069/compile-vim-with-clipboard-and-xterm
      sudo -E apt build-dep -y lua5.2 lua5.2-dev libperl-dev python-dev python3-dev libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev vim #vim
      ;;
    *)
      ;;
  esac
}

install_docker() {
  # https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce-1
  sudo -E apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo -E add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

  sudo -E apt-get update
  sudo -E apt-get install -y docker-ce

  DIR=/etc/systemd/system/docker.service.d
  sudo mkdir -p $DIR
  sudo sh -c "echo '[Service]' >> $DIR/http-proxy.conf"
  sudo -E sh -c "echo \"Environment=\"HTTP_PROXY=$http_proxy\" \"NO_PROXY=$no_proxy\"\" >> $DIR/http-proxy.conf"
  sudo sh -c "echo '[Service]' >> $DIR/https-proxy.conf"
  sudo -E sh -c "echo \"Environment=\"HTTPS_PROXY=$https_proxy\" \"NO_PROXY=$no_proxy\"\" >> $DIR/https-proxy.conf"

  sudo systemctl daemon-reload
  sudo systemctl restart docker
  sudo systemctl enable docker

  sudo -E docker run hello-world
}

install_xvfb() {
  # if type Xvfb > /dev/null 2>&1; then echo 'xvfb has already installed. skipping..'; return ; fi
  echo 'export DISPLAY=:1' >> $HOME/.bash_profile
  sudo -E ln -s $DOTFILES_HOME/init.d/xvfb /etc/init.d/xvfb
  sudo -E sysv-rc-conf xvfb on
  sudo -E systemctl daemon-reload
}

install_chrome() {
  sudo -E apt install -y fonts-liberation libappindicator1 libnspr4 libnss3
  # sudo -E apt-get -f install #if error
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo -E dpkg -i ./google-chrome-stable_current_amd64.deb
  echo 'PATH=$PATH:/opt/google/chrome' >> ~/.bash_profile
}

install_concourse() {
  sudo -E apt install -y postgresql postgresql-contrib
  # sudo -u postgres createuser concourse
  # sudo -u postgres createdb --owner=concourse atc

  curl -LO https://github.com/concourse/concourse/releases/download/v3.11.0/concourse_linux_amd64
  curl -LO https://github.com/concourse/concourse/releases/download/v3.11.0/fly_linux_amd64

  chmod +x concourse_linux_amd64 fly_linux_amd64
  sudo mv concourse_linux_amd64 /usr/local/bin/concourse
  sudo mv fly_linux_amd64 /usr/local/bin/fly

  # grant access from any local user (as postgres)
  # /etc/postgresql/9.5/main/pg_hba.conf
  # local   all             postgres                                trust

  # psql -U postgres
  # ALTER USER postgres with encrypted password 'password';

  # invoke start_concourse.bash

  ## sudo mkdir /etc/concourse
  ## sudo ssh-keygen -t rsa -q -N '' -f /etc/concourse/tsa_host_key
  ## sudo ssh-keygen -t rsa -q -N '' -f /etc/concourse/worker_key
  ## sudo ssh-keygen -t rsa -q -N '' -f /etc/concourse/session_signing_key
  ## sudo cp /etc/concourse/worker_key.pub /etc/concourse/authorized_worker_keys
}

install_latest_gcc() {
  # https://gist.github.com/application2000/73fd6f4bf1be6600a2cf9f56315a2d91
  # NOTE: cannot add-apt-repository in an insecure env (ssl-validation-error)
  sudo -E add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
  sudo -E apt update && \
  sudo -E apt install gcc-7 g++7 -y && \
  sudo -E update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/g++ g++ /usr/bin/g++7
  # When completed, you must change to the gcc you want to work with by default. Type in your terminal:
  # sudo -E update-alternatives --config gcc
}

install_bash_it() {
  [ `eval $IS_CYG` ] && return || :

  [ -d $HOME/.bash_it ] && mv $HOME/.bash_it $BACKUPDIR/.bash_it || :
  rm -rf $DOTFILES_HOME/.bash_it/custom
  ln -s $DOTFILES_HOME/custom $DOTFILES_HOME/.bash_it/custom
  ln -s $DOTFILES_HOME/.bash_it $HOME/.bash_it
  $HOME/.bash_it/install.sh
}

install_tmux() {
  [ `eval $IS_CYG` ] && return || :
  if [ -f /usr/local/bin/tmux ]; then echo 'tmux has already installed. skipping..'; return; fi

  cd $DOTFILES_HOME/tmux
  git checkout $(git tag | sort -V | tail -n 1)
  ./autogen.sh
  ./configure
  make
  sudo -E make install
  echo 'source $HOME/.bashrc' >> ~/.bash_profile
}

install_rbenv() {
  [ `eval $IS_CYG` ] && return || :
  if type rbenv > /dev/null 2>&1; then echo 'rbenv has already installed. skipping..'; return ; fi

  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

  mkdir -p $HOME/.rbenv/plugins
  git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build

  if $IS_INSECURE ; then sed -i 's/CURL_OPTS="/CURL_OPTS="--insecure /g' ~/.rbenv/plugins/ruby-build/bin/ruby-build; fi

  source ~/.bash_profile

  rbenv install 2.5.0
  rbenv global 2.5.0
}

install_pyenv() {
  [ `eval $IS_CYG` ] && return || :
  if type pyenv > /dev/null 2>&1; then echo 'pyenv has already installed. skipping..'; return; fi

  curl --insecure -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

  echo 'export PATH="/home/vagrant/.pyenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
  echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile

  if $IS_INSECURE ; then sed -i 's/CURL_OPTS="/CURL_OPTS="--insecure /g' ~/.pyenv/plugins/python-build/bin/python-build; fi

  source ~/.bash_profile

  CONFIGURE_OPTS="--enable-shared" pyenv install anaconda3-5.1.0
  pyenv global anaconda3-5.1.0

  PASSWORD_HASH=`python $HOME/.jupyter/passwd.py`
  echo "c.NotebookApp.password = u'$PASSWORD_HASH'" >> $HOME/.jupyter/jupyter_notebook_config.py

  STARTUP_DIR=".ipython/profile_default/startup"
  cd $DOTFILES_HOME/$STARTUP_DIR && ls *.ipy | xargs -I{} ln -s $DOTFILES_HOME/$STARTUP_DIR/{} ~/$STARTUP_DIR/{}
}

install_jupyter() {
  if [ $IS_INSECURE ]; then conda config --set ssl_verify False; fi
  conda install -y -c conda-forge jupyter_contrib_nbextensions
  conda install -y -c damianavila82 rise
  conda install -y -c conda-forgejupyter_cms
  # pip install jupyter_cms
  # jupyter cms quick-setup --sys-prefix
}

install_vim() {
  [ `eval $IS_CYG` ] && return || :
  # TODO: cyg http://koturn.hatenablog.com/entry/2015/12/14/090000

  # if [ -f /usr/local/bin/vim ]; then echo 'vim has already installed. skipping..'; return; fi

  cd $DOTFILES_HOME/vim/src
  make distclean

  # because of linker error, excluded lto by LDFLAGS
  LDFLAGS="-fno-lto" \
  ./configure \
    --with-features=huge \
    --enable-fail-if-missing \
    --disable-selinux \
    --enable-luainterp \
    --enable-perlinterp \
    --enable-python3interp \
    --enable-rubyinterp=dynamic \
    --enable-cscope \
    --enable-fontset \
    --enable-multibyte \
    --with-ruby-command=$HOME/.rbenv/shims/ruby \
    --with-x \
    --prefix=/usr/local
  make
  # sudo -E make install

  # `make distclean` to clear configure cache

  # osx
  # ./configure \
    # --with-features=huge \
    # --enable-fail-if-missing \
    # --enable-luainterp=yes\
    # --enable-perlinterp=yes \
    # --enable-python3interp=yes \
    # --enable-rubyinterp=dynamic \
    # --enable-multibyte \
    # --enable-cscope \
    # --enable-fontset \
    # --prefix=/opt \
    # --with-lua-prefix=/usr/local

}

unsecuring_pip() {
  # https://qiita.com/wonder_zone/items/f00de737fd2e1eeb6581
  FILE="~/.pyenv/versions/anaconda3-5.1.0/lib/python3.6/site-packages/pip/_internal/download.py"
  sed -i 's/(method, url, \*args, \*\*kwargs/(method, url, verify=False, \*args, \*\*kwargs/g' $FILE
}

cd $DOTFILES_HOME

if [ -d $BACKUPDIR ]; then
  echo 'backup exists. skipping..'
else
  mkdir -p $BACKUPDIR
  backup
  common
fi

# install_dependency
# install_bash_it
# install_xvfb
# install_tmux
# install_rbenv
# install_pyenv
# install_vim
# install_docker
# install_jupyter

echo "DONE!"


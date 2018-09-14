#!/bin/bash

# set -eux

echo "## variables"

DOTFILES_HOME="$HOME/.dotfiles"
BASH_PROFILE="$HOME/.bash_profile"

IS_CYG="uname | grep CYG"
DIST=$(awk -F'=' '/^NAME/{print $2}' /etc/os-release)
[ "$DIST" = "CentOS Linux" ]; IS_CENTOS=true
[ "$DIST" = "Ubuntu" ]; IS_UBUNTU=false
echo "- DIST: $DIST"

NODE_VERSION="8.3.0"
RUBY_VERSION="2.5.0"
PYTHON_VERSION="anaconda3-5.1.0"

echo "## commands"

install_docker() {
  echo "***** install_docker *****"
  # https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce-1
  sudo -E apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo -E add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

  sudo -E apt update
  sudo -E apt install -y docker-ce

  DIR=/etc/systemd/system/docker.service.d
  sudo mkdir -p $DIR
  sudo sh -c "echo '[Service]' >> $DIR/http-proxy.conf"
  sudo -E sh -c "echo \"Environment=\"HTTP_PROXY=$http_proxy\" \"NO_PROXY=$no_proxy\"\" >> $DIR/http-proxy.conf"
  sudo sh -c "echo '[Service]' >> $DIR/https-proxy.conf"
  sudo -E sh -c "echo \"Environment=\"HTTPS_PROXY=$https_proxy\" \"NO_PROXY=$no_proxy\"\" >> $DIR/https-proxy.conf"

  sudo systemctl daemon-reload
  sudo systemctl restart docker
  sudo systemctl enable docker
}

install_xvfb() {
  echo "***** install_xvfb *****"
  # if type Xvfb > /dev/null 2>&1; then echo 'xvfb has already installed. skipping..'; return ; fi
  sudo -E apt install -y xserver-xorg xvfb sysv-rc-conf #xvfb
  echo 'export DISPLAY=:1' >> $BASH_PROFILE
  sudo -E ln -s $DOTFILES_HOME/init.d/xvfb /etc/init.d/xvfb
  sudo -E sysv-rc-conf xvfb on
  sudo -E systemctl daemon-reload
}

install_chrome() {
  echo "***** install_chrome *****"
  sudo -E apt install -y fonts-liberation libappindicator1 libnspr4 libnss3
  # sudo -E apt-get -f install #if error
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo -E dpkg -i ./google-chrome-stable_current_amd64.deb
  echo 'PATH=$PATH:/opt/google/chrome' >> $BASH_PROFILE
}

install_latest_gcc() {
  echo "***** install_latest_gcc *****"
  # https://gist.github.com/application2000/73fd6f4bf1be6600a2cf9f56315a2d91
  # NOTE: cannot add-apt-repository in an insecure env (ssl-validation-error)
  sudo -E add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
  sudo -E apt update && \
  sudo -E apt install gcc-7 g++7 -y && \
  sudo -E update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/g++ g++ /usr/bin/g++7
  # When completed, you must change to the gcc you want to work with by default. Type in your terminal:
  # sudo -E update-alternatives --config gcc
}

install_concourse() {
  echo "***** install_concourse *****"
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

install_node() {
  nodebrew setup
  nodebrew install-binary stable
  nodebrew install-binary $NODE_VERSION
  nodebrew use $NODE_VERSION
}

unsecuring_pip() {
  # https://qiita.com/wonder_zone/items/f00de737fd2e1eeb6581
  FILE="~/.pyenv/versions/$PYTHON_VERSION/lib/python3.6/site-packages/pip/_internal/download.py"
  sed -i 's/(method, url, \*args, \*\*kwargs/(method, url, verify=False, \*args, \*\*kwargs/g' $FILE
}

# -----------------------------------------------------------

cd $DOTFILES_HOME

# install_concourse
# install_latest_gcc
# install_chrome
# install_docker
# install_xvfb

# install_node #TODO LINUX
# unsecuring_pip

echo "DONE!"


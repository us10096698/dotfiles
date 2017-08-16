#! /bin/sh

set -eux

dotfiles_dir="$HOME/.dotfiles"
backupdir="$HOME/.dotfiles.backup"
is_cyg="uname | grep CYG"

bash_it_installation()
{
  [ `eval $is_cyg` ] && return

  [ -d $HOME/.bash_it ] && mv $HOME/.bash_it $backupdir/.bash_it
  git submodule init
  git submodule update
  rm -rf $dotfiles_dir/.bash_it/custom
  ln -s $dotfiles_dir/custom $dotfiles_dir/.bash_it/custom
  ln -s $dotfiles_dir/.bash_it $HOME/.bash_it
  sh $HOME/.bash_it/install.sh
}

backup() {
  [ -f $HOME/.bash_profile ] && mv $HOME/.bash_profile "$backupdir"/.bash_profile
  [ -f $HOME/.vimrc ] && mv $HOME/.vimrc "$backupdir"/.vimrc
  [ -f $HOME/.gvimrc ] && mv $HOME/.gvimrc "$backupdir"/.gvimrc
  [ -f $HOME/.tmux.conf ] && mv $HOME/.tmux.conf "$backupdir"/.tmux.conf
  [ -f $HOME/.dir_colors ] && mv $HOME/.dir_colors "$backupdir"/.dir_colors
  [ -f $HOME/.gitconfig ] && mv $HOME/.gitconfig "$backupdir"/.gitconfig
}

link() {
  [ `eval $is_cyg` ] && export CYGWIN=winsymlinks:native

  ln -s $dotfiles_dir/.vimrc $HOME/.vimrc
  ln -s $dotfiles_dir/.gvimrc $HOME/.gvimrc
  ln -s $dotfiles_dir/.tmux.conf $HOME/.tmux.conf
  ln -s $dotfiles_dir/.gitconfig $HOME/.gitconfig
  ln -s $dotfiles_dir/.dir_colors $HOME/.dir_colors
}

cd $dotfiles_dir
[ -d $backupdir ] && : || mkdir -p $backupdir

bash_it_installation
backup
link

echo "DONE!"
echo " *** NOTICE *** Original dotfiles are copied into $backupdir"


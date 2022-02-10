#!/usr/bin/bash

set -e

# Back up and replace configuration files
HOMENAMES=(.bashrc .vimrc .tmux.conf .gitconfig .ssh/config)
REPONAMES=(bashrc vimrc tmux.conf gitconfig ssh_config)

if [ ! -d backups ]; then
  mkdir backups
fi

for i in ${!HOMENAMES[@]}; do
  HOMEN=${HOMENAMES[$i]}
  REPON=${REPONAMES[$i]}

  if [ -e ~/$HOMEN ] && [ ! -e backups/$REPON ]; then
    echo "Backing up $HOMEN to backups/$REPON"
    cp ~/$HOMEN backups/$REPON
  fi
  cp myconfs/$REPON ~/$HOMEN
done

# Clone Vundle
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

(vim +PluginInstall &> /dev/null &)

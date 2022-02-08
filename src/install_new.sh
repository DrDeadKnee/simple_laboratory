#!/bin/bash

set -eu

HOME=$(sudo echo ~)
USER=$HOME | tr "/" | awk '{print$NF;}'

if [ "$EUID" -ne 0 ]; then
  echo "This needs to be run as root! Try again with 'sudo'."
  echo "For more information, see https://xkcd.com/149/"
  exit 1
fi

echo "This may take a while, and it will take a gig or two of HD space"
echo "Do you wish to continue?"
select yn in "Yes" "No"; do
    case $yn in 
        Yes ) break;;
        No ) exit;;
    esac
done

echo "Updating Repositories"
apt-get update

echo "Installing Git"
apt-get install git

echo "Replacing Vim"
apt-get -y remove vim-tiny
apt-get -y update
apt-get -y install vim
apt-get -y install tree

echo "Removing Superfluous Packages"
apt autoremove

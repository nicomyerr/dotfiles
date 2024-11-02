#!/bin/bash

if pacman -Qs go-yq > /dev/null ; then
  echo "yq already installed"
else
  echo "yq is not installed"
  sudo pacman -S go-yq
fi

source $PWD/src/install-packages.sh
source $PWD/src/copy-configfiles.sh

// TODO: installing oh-my-zsh and fix for autosuggestions + syntaxhighlight
echo "Installing packages..."
install_packages
echo """
Finished installing packages
"""

echo "Copying configfiles..."
copy_configfiles
echo """
Finished copying configfiles
"""

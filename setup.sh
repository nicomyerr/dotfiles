#!/bin/bash

if pacman -Qs go-yq > /dev/null ; then
  echo "yq already installed"
else
  echo "yq is not installed"
  sudo pacman -S go-yq
fi

source $PWD/src/install-packages.sh
source $PWD/src/copy-configfiles.sh

echo "Installing packages..."
install_packages
echo """
Finished installing packages
"""
# TODO: check if ohmyzsh is not installed and fix for plugins already done
echo "Installing ohmyzsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Fixing autosuggestions and syntaxhighlighting plugin"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


echo "Do you want to copy the configfiles/dotfiles? [y/n]"
read copy_configfiles < /dev/tty

if [ "$copy_configfiles" == "y" ]; then
  echo "Copying configfiles..."
  copy_configfiles
  echo """
  Finished copying configfiles
  """
elif [ "$copy_configfiles" == "n" ]; then
  echo "Not copying configfiles."
else
  echo "You should write 'y' or 'n' :("
fi


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

if [ -d ~/.oh-my-zsh ]; then
  echo "ohmyzsh already installed"
else
  echo "Installing ohmyzsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  echo "zsh-autosuggestions already fixed"
else
  echo "Fixing zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  echo "zsh-syntax-highlighting already fixed"
else
  echo "Fixing zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

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

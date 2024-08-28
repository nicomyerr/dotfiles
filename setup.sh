#!/bin/bash

# installing yq to install packages (if not installed)
# sudo pacman -S go-yq

source $PWD/src/install-packages.sh
source $PWD/src/copy-configfiles.sh

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

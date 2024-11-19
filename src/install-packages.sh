#!/bin/bash

function install_packages_with_packagemanager() {
  while read package; do
    if ${packagemanager} -Qs ${package} > /dev/null ; then
      echo "'${package}' is already installed"
    else
      echo "Installing '${package}'"
      if [ "$packagemanager" == "pacman" ]; then
        sudo pacman -S ${package} < /dev/tty
      elif [ "$packagemanager" == "yay" ]; then
        yay -S ${package} < /dev/tty
      else
        echo "Invalid packagemanager '${packagemanager}'"
      fi
    fi
  done < <(echo "$1")
}

function install_packages() {
  packagemanagers=$(yq .packages system.yaml | grep -v '-' | tr -d ':')
  while read packagemanager; do
    echo "Installing packages with '${packagemanager}'"
    packages=$(yq .packages.${packagemanager} system.yaml | cut -c2-)
    install_packages_with_packagemanager "${packages}"
    echo "Finished installing '${packagemanager}' packages"
  done < <(echo "${packagemanagers}")
}

#!/bin/bash

function install_packages_with_packagemanager() {
  while read package; do
    if ${packagemanager} -Qs ${package} > /dev/null ; then
      echo "'${package}' is already installed"
    else
      echo "installing '${package}'"
      // TODO: dont install packages with sudo for yay
      sudo ${packagemanager} -S ${package} < /dev/tty
    fi
  done < <(echo "$1")
}

function install_packages() {
  packagemanagers=$(yq .packages system.yaml | grep -v '-' | tr -d ':')
  while read packagemanager; do
    echo "Installing packages with '${packagemanager}'"
    packages=$(yq .packages.${packagemanager} system.yaml | sed 's|[- "]||g')
    install_packages_with_packagemanager "${packages}"
    echo "Finished installing '${packagemanager}' packages"
  done < <(echo "${packagemanagers}")
}

#!/bin/bash

function install_packages_with_packagemanager() {
  while read PACKAGE; do
    if ${PACKAGEMANAGER} -Qs ${PACKAGE} > /dev/null ; then
      echo "'${PACKAGE}' is already installed"
    else
      echo "installing '${PACKAGE}'"
      # this doesnt work :(
      # sudo ${PACKAGEMANAGER} -S ${PACKAGE}
    fi
  done < <(echo "$1")
}

function install_packages() {
  PACKAGEMANAGERS=$(yq .packages system.yaml | grep -v '-' | tr -d ':')
  while read PACKAGEMANAGER; do
    echo "Installing packages with '${PACKAGEMANAGER}'"
    PACKAGES=$(yq .packages.${PACKAGEMANAGER} system.yaml | sed 's|[- "]||g')
    install_packages_with_packagemanager "${PACKAGES}"
    echo "Finished installing '${PACKAGEMANAGER}' packages"
  done < <(echo "${PACKAGEMANAGERS}")
}

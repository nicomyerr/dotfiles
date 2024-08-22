#!/bin/bash

function install_packages_with_packagemanager() {
  while read PACKAGE; do
    echo "sudo ${PACKAGEMANAGER} -S ${PACKAGE}"
  done < <(echo "$1")
}

function install_packages() {
  PACKAGEMANAGERS=$(yq packages.yaml | grep -v '-' | tr -d ':')
  while read PACKAGEMANAGER; do
    echo "Installing packages with '${PACKAGEMANAGER}'"
    PACKAGES=$(yq .${PACKAGEMANAGER} packages.yaml | sed 's|[- "]||g')
    install_packages_with_packagemanager "${PACKAGES}"
    echo "Finished installing '${PACKAGEMANAGER}' packages"
  done < <(echo "${PACKAGEMANAGERS}")
}

PACKAGEMANAGERS=$(yq packages.yaml | grep -v '-' | tr -d ':')

install_packages() {
  while read PACKAGE; do
    echo "sudo ${PACKAGEMANAGER} -S ${PACKAGE}"
  done < <(echo $1)
}

while read PACKAGEMANAGER; do
  echo "Installing packages with '${PACKAGEMANAGER}'"
  PACKAGES=$(yq .${PACKAGEMANAGER} packages.yaml | sed 's|[- "]||g')
  install_packages ${PACKAGES}
  echo "Finished installing '${PACKAGEMANAGER}' packages"
done < <(echo "${PACKAGEMANAGERS}")

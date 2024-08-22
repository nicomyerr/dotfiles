PACKAGEMANAGERS=$(yq packages.yaml | grep -v '-' | tr -d ':')

while read PACKAGEMANAGER; do
  echo "Installing packages with '${PACKAGEMANAGER}'"
  PACKAGES=$(yq .${PACKAGEMANAGER} packages.yaml | sed 's|[- "]||g')
  while read PACKAGE; do
    echo "sudo ${PACKAGEMANAGER} -S ${PACKAGE}"
  done < <(echo "${PACKAGES}")
  echo "Finished installing '${PACKAGEMANAGER}' packages"
done < <(echo "${PACKAGEMANAGERS}")

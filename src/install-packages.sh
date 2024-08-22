readarray PACKAGEMANAGERS < <(yq packages.yaml | grep -v '-' | tr -d ':')

for PACKAGEMANAGER in "${PACKAGEMANAGERS[@]}"; do
  echo "Installing packages with ${PACKAGEMANAGER}"
  PACKAGES=$(yq .${PACKAGEMANAGER} packages.yaml)
  echo "${PACKAGES}"
done

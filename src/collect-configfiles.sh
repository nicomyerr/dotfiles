#!/bin/bash

function collec_configfiles() {
  config_files=$(yq .config-files system.yaml | sed 's|[- ]||g')

  while read config_file; do
    app=$(echo ${config_file} | cut -d ":" -f 1)
    path=$(echo ${config_file} | cut -d ":" -f 2 | sed 's|["]||g')

    full_path="$HOME/$path"

    echo "app: $app path: $full_path"

    if [[ $path =~ ".config" ]]; then
      echo "Copying configfiles for '$app' to repo"
      cp -r $full_path/. config/$app/
    else
      echo "Copying configfile for '$app' to repo"
      cp -r $full_path config/$app/
    fi
  done < <(echo "${config_files}")
}

collec_configfiles

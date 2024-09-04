#!/bin/bash

function get_full_path () {
  if [ ! -z $1 ]; then
    echo "$HOME/$path"
  else
    echo $HOME
  fi
}

function collec_configfiles() {
  config_files=$(yq .config-files system.yaml | sed 's|[- ]||g')

  while read config_file; do
    app=$(echo ${config_file} | cut -d ":" -f 1)
    path=$(echo ${config_file} | cut -d ":" -f 2 | sed 's|["]||g')

    full_path=$(get_full_path "$path")

    if [ ! -z $path ]; then
      echo "Copying configfiles for '$app' to repo"
      cp -r $full_path/. config/$app/
    fi

  done < <(echo "${config_files}")
}

collec_configfiles

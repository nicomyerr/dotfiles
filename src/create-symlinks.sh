#!/bin/bash

config_files=$(yq .config-files system.yaml | sed 's|[- ]||g')

while read config_file; do
  app=$(echo ${config_file} | cut -d ":" -f 1)
  path=$(echo ${config_file} | cut -d ":" -f 2 | sed 's|["]||g')

  full_path="$HOME/$path"

  echo "app: $app path: $full_path"

  echo "ln -sf $full_path /config/$app"

  if [[ $path =~ ".config" ]]; then
    # multiple configfiles
    echo "Create symlinks for '$app'"
  else
    # single configfiles
    echo "Create symlink for '$app'"
  fi
done < <(echo "${config_files}")

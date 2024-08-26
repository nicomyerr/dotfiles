#!/bin/bash

config_files=$(yq .config-files system.yaml | sed 's|[- ]||g')

# TODO: refactoring

while read config_file; do
  app=$(echo ${config_file} | cut -d ":" -f 1)
  path=$(echo ${config_file} | cut -d ":" -f 2 | sed 's|["]||g')
  full_path="$HOME"
  if [ ! -z $path ]; then
    full_path="$HOME/$path"
  fi
  if [ ! -d $full_path ]; then
    echo "creating directory '$full_path'"
    mkdir $full_path
    echo "copying config file(s) of '${app}' to local directory: '$full_path'"
    cp -r config/$app/. $full_path/
  else
    echo "directory '$full_path' already exists"
    # FIXME: not working :(
    # read "override_files?should the current files be overriden? [y/n]"
    # TODO: ignore case of user input
    if [ "$override_files" == "y" ]; then
      echo "copying config file(s) of '${app}' to local directory: '$full_path'"
      cp -r config/$app/. $full_path/
    elif [ "$override_files" == "n" ]; then
      echo "doing nothing :)"
    else
      echo "you should write 'y' or 'n' :("
    fi
  fi
done < <(echo "${config_files}")

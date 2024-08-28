#!/bin/bash

# TODO: refactoring
# TODO: handling for e.g. zsh -> $HOME/.zshrc

function get_full_path () {
  if [ ! -z $1 ]; then
    echo "$HOME/$path"
  else
    echo $HOME
  fi
}

function copy_not_existing_configfiles() {
  path=$1
  app=$2

  echo "creating directory '$path'"
  mkdir $path
  echo "copying config file(s) of '${app}' to local directory: '$path'"
  cp -r config/$app/. $path/
}

function copy_existing_configfiles() {
  path=$1
  app=$2

  echo "directory '$path' already exists"
  # FIXME: not working :(
  # read "override_files?should the current files be overriden? [y/n]"
  if [ "$override_files" == "y" ]; then
    echo "copying config file(s) of '${app}' to local directory: '$path'"
    cp -r config/$app/. $path/
  elif [ "$override_files" == "n" ]; then
    echo "doing nothing :)"
  else
    echo "you should write 'y' or 'n' :("
  fi
}

function copy_configfiles_for_app() {
  path=$1
  app=$2

  if [ ! -d $path ]; then
    copy_not_existing_configfiles "$path" "$app"
  else
    copy_existing_configfiles "$path" "$app"
  fi
}

function copy_configfiles() {
  config_files=$(yq .config-files system.yaml | sed 's|[- ]||g')
  while read config_file; do
    app=$(echo ${config_file} | cut -d ":" -f 1)
    path=$(echo ${config_file} | cut -d ":" -f 2 | sed 's|["]||g')

    full_path=$(get_full_path "$path")

    copy_configfiles_for_app "$full_path" "$app"
  done < <(echo "${config_files}")
}

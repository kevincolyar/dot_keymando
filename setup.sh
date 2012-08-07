#!/usr/bin/env bash

function clone_repo
{
  name=$(echo $1 | cut -d'/' -f2)

  if [ -e plugins/$name ]; then
    echo "$name exists. Skipping..."
  else
    url="git@github.com:$1.git"
    echo "Cloning $url to plugins/$name"
    git clone $url plugins/$name
  fi
}

plugins="
keymando/abbrev
keymando/application_launcher
keymando/chrome_bookmarks
keymando/file_system
keymando/find
keymando/keychain
keymando/network_location
keymando/spotify
keymando/underscore"

for plugin in $plugins; do
  clone_repo $plugin
done


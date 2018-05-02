#!/usr/bin/env bash

# Do a `git fetch` on all repositories recursively,
# starting from the current directory.

_command="git fetch --all"
_parent_dir=$(pwd)

find . -type d -name ".git" | while read _directory; do
  _dir_with_repo=${_directory%.*} # Removes the `.git` at the end
  cd $_dir_with_repo
  echo "Inside $_dir_with_repo ..."

  $_command

  echo "---"
  cd $_parent_dir
done

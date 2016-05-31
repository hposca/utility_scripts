#!/usr/bin/env bash

# Uses the list_upgradable_packages script to check if there are new packages
# to upgrade

# With a big help of
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
# to solve how to find the real path where the script is stored

SOURCE="${BASH_SOURCE[0]}"
# resolve $SOURCE until the file is no longer a symlink
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  # if $SOURCE was a relative symlink, we need to resolve it relative to the
  # path where the symlink file was located
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

old_dir=$(pwd)
sudo apt-get update && \
  cd $DIR/package_management/debian && \
  ./list_upgradable_packages.sh > /tmp/upgradable ; \
  cd $old_dir ; \
  cat /tmp/upgradable

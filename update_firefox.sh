#!/usr/bin/env bash

# Unofficial Bash Strict Mode
# Read more about it in http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

set +u
source shml.sh
set -u

#########
# Begin #
#########

_temp_dir=$(mktemp -d)
echo "$(color lightyellow ">>>>> Created temporary directory: $_temp_dir")"
cd $_temp_dir

echo "$(color green ">>>>> Downloading newest version of firefox...")"

_firefox_url="https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
wget -O firefox.tar.bz2 $_firefox_url

echo "$(color green ">>>>> Extracting files...")"

_firefox_file=$(ls *.bz2)
tar -jxf $_firefox_file

echo "$(color green ">>>>> Moving files to the right place...")"

sudo mv /usr/lib/firefox /usr/lib/firefox-$(date +%Y%m%d)
sudo mv firefox /usr/lib/
sudo chown -R root:root /usr/lib/firefox

echo "$(color lightgreen ">>>>> Firefox updated.")"

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
cd $_temp_dir

echo "$(color green ">>>>> Downloading newest version of firefox...")"

_firefox_url="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/"
wget -A.bz2 -r -np -nd $_firefox_url -P .

echo "$(color green ">>>>> Extracting files...")"

_firefox_file=$(ls *.bz2)
tar -jxf $_firefox_file

echo "$(color green ">>>>> Moving files to the right place...")"

sudo mv /usr/lib/firefox /usr/lib/firefox-$(date +%Y%m%d)
sudo mv firefox /usr/lib/
sudo chown -R root:root /usr/lib/firefox

echo "$(color lightgreen ">>>>> Firefox updated.")"

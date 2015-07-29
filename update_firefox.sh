#!/usr/bin/env bash

# Unofficial Bash Strict Mode
# Read more about it in http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

#########
# Begin #
#########

_temp_dir=$(mktemp -d)
cd $_temp_dir

_firefox_url="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/"
wget -A.bz2 -r -np -nd $_firefox_url -P .

_firefox_file=$(ls *.bz2)
tar -jxf $_firefox_file

sudo mv /usr/lib/firefox /usr/lib/firefox-$(date +%Y%m%d)
sudo mv firefox /usr/lib/
sudo chown -R root:root /usr/lib/firefox

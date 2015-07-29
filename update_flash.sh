#!/usr/bin/env bash

# Unofficial Bash Strict Mode
# Read more about it in http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

#########
# Begin #
#########

# Find the newest Flash URL in https://get.adobe.com/flashplayer/
_update_url="https://fpdownload.adobe.com/get/flashplayer/pdc/11.2.202.491/install_flash_player_11_linux.x86_64.tar.gz"

_inner_flash_dir="uncompressed_flash"

_new_flash_dir="$(mktemp -d)"
cd $_new_flash_dir

wget -r -np -nd $_update_url -P .

_flash_gzip=$(ls *flash*.tar.gz)

mkdir $_inner_flash_dir
tar -xzf $_flash_gzip -C $_inner_flash_dir

sudo cp $_inner_flash_dir/libflashplayer.so /usr/lib/adobe-flashplugin/libflashplayer.so
sudo cp -r $_inner_flash_dir/usr/* /usr

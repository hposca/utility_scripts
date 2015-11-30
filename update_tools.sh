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
echo "$(color green ">>>>> Updating tools...")"

sudo -H pip install \
  ansible \
  awscli \
  awsebcli \
  boto \
  ipython \
  pip \
  pyrg \
  saws \
  --upgrade

echo "$(color lightgreen ">>>>> Tools updated.")"

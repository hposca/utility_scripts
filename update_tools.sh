#!/usr/bin/env bash

# Unofficial Bash Strict Mode
# Read more about it in http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

#########
# Begin #
#########
sudo -H pip install \
  ansible \
  awscli \
  awsebcli \
  boto \
  ipython \
  pip \
  pyrg \
  --upgrade

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

echo "$(color green "Will generate the list of upgradable packages in a CSV like format...")"
echo ""

echo "Package Name,Installed Version,Available Version"

apt-get -u -V -s upgrade | \
  grep ".*=>.*" | \
  sort | \
  awk 'BEGIN {OFS=","} {print $1, $2, $4}' | \
  sed 's/[()]//g'

echo ""
echo "$(color lightgreen "List of upgradable packages generated.")"

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

echo "$(color green "Will generate the list of installed packages in a CSV like format...")"
echo ""

echo "Package Name,Installed Version"

dpkg-query -l | grep '^i' | sort | awk 'BEGIN {OFS=","} {print $2,$3}'

echo ""
echo "$(color lightgreen "List of installed packages generated.")"

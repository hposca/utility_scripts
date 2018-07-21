#!/usr/bin/env bash

# Unofficial Bash Strict Mode
# Read more about it in http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set +u
source "${SCRIPT_DIR}/shml.sh"
set -u
#########
# Begin #
#########
_time_to_sleep=3

trap bashtrap EXIT

function bashtrap() {
  echo
  echo "$(color yellow "Stopped watching the file.")"
  echo "$(color green "Thanks for using this script!")"
  exit 0
}

function printUsage() {
  echo "Please use this script this way:"
  echo "$0 file_to_watch command(s)"
}

function check_arguments() {
  if [ "$#" -lt 2 ]; then
    printUsage
    exit 1
  fi
}

function get_last_modification_time() {
  echo $(stat -c %y $@ | awk '{printf $2}')
}

check_arguments "$@"

_file_to_watch=$1
shift
_command_to_run=$*

echo "$(color green "Will watch for modifications in the $_file_to_watch file.")"
echo "$(color green "And will run the following command:")" $_command_to_run
echo "$(color lightyellow "Press CTRL + C to stop watching for modifications in the file.")"
echo "$(color yellow "If the given command exits due to a problem this script will stop.")"

_last_modification=$(get_last_modification_time $_file_to_watch)
while : ; do
  sleep $_time_to_sleep

  _newest_time=$(get_last_modification_time $_file_to_watch)

  if [ $_newest_time != $_last_modification ]; then
    echo ""
    echo "$(color cyan "File $_file_to_watch was updated...")"
    echo "$(color lightcyan "Running")" \"$_command_to_run\"
    echo ""

    $_command_to_run

    _last_modification=$_newest_time
  fi
done

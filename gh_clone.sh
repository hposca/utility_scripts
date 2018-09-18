#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ "$#" -ne 1 ]]; then
  echo "Clones a GitHub repository into a directory which is the username part of the path."
  echo "SSH format only: git@github.com:username/repository.git"
  echo ""
  echo "Please provide the github (SSH) path for the repository, like:"
  echo ""
  echo "$0 git@github.com:username/repository.git"
  exit 1
fi

github_repo="$1"
directory=$(echo "${github_repo}" | awk -F':' '{print $2}' | awk -F'/' '{print $1}')
repo_name=$(echo "${github_repo}" | awk -F':' '{print $2}' | awk -F'/' '{print $2}' | awk -F'.' '{print $1}')

_curdir=$(pwd)
mkdir -p $directory

cd "${directory}"
git clone "${github_repo}"
cd "${_curdir}"

echo ""
echo "Cloned repository ${repo_name} into ${directory} directory :)"

#!/usr/bin/env bash

# Script used to "git pull" into all repositories, beginning from the root directory.
# It actually fetches first, then if not on a feature branch, reset to origin.

function fetch {
  # git fetch --prune --all
  git fetch --all
}

function git_current_branch {
  git rev-parse --abbrev-ref HEAD
}

function is_master {
  local branch="${1}"
  local master_branches="master main trunk base"

  echo "${master_branches}" | grep -w "${branch}" > /dev/null
}

find . -maxdepth 2 -type d -name ".git" | while read _directory; do
  _dir_with_repo=${_directory%.*} # Removes the '.git' at the end
  pushd "${_dir_with_repo}"
  echo "Inside ${_dir_with_repo} ..."

  fetch
  if is_master $(git_current_branch); then
    git reset origin/$(git_current_branch) --hard
  fi

  popd
  echo "---"
done

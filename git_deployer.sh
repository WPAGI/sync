#!/bin/bash
# git_deployer.sh - Standalone Git deployment script
# Usage: ./git_deployer.sh <repo-url-or-zip> [base-dir] [branch]
# Clones or updates a repository, or extracts a zip, in a chosen directory.

set -e

REPO_SOURCE="$1"
BASE_DIR="${2:-.}"
BRANCH="${3:-main}"

if [ -z "$REPO_SOURCE" ]; then
  echo "Usage: $0 <repo-url-or-zip> [base-dir] [branch]" >&2
  exit 1
fi

# Gather list of folders for dropdown selection
mapfile -t DIRS < <(find "$BASE_DIR" -maxdepth 1 -type d -printf '%P\n' | sort)
if [ "${#DIRS[@]}" -eq 0 ]; then
  echo "No directories found in $BASE_DIR" >&2
  exit 1
fi

echo "Select target directory:" >&2
PS3="Choice: "
select CHOICE in "${DIRS[@]}" "Other"; do
  if [ -n "$CHOICE" ]; then
    if [ "$CHOICE" = "Other" ]; then
      read -rp "Enter directory path: " TARGET_DIR
    else
      TARGET_DIR="$BASE_DIR/$CHOICE"
    fi
    break
  fi
done

mkdir -p "$TARGET_DIR"

if [[ "$REPO_SOURCE" == *.zip ]]; then
  echo "Extracting $REPO_SOURCE into $TARGET_DIR"
  unzip -o "$REPO_SOURCE" -d "$TARGET_DIR"
else
  if [ ! -d "$TARGET_DIR/.git" ]; then
    echo "Cloning $REPO_SOURCE into $TARGET_DIR"
    git clone --branch "$BRANCH" "$REPO_SOURCE" "$TARGET_DIR"
  else
    echo "Updating existing repo in $TARGET_DIR"
    cd "$TARGET_DIR"
    git fetch origin
    git checkout "$BRANCH"
    git pull origin "$BRANCH"
  fi
fi


#!/bin/bash
# git_deployer.sh - Standalone Git deployment script
# Usage: ./git_deployer.sh <repo-url> [target-dir] [branch]
# Clones or updates a repository in the target directory.

set -e

REPO_URL="$1"
TARGET_DIR="${2:-$(basename "$REPO_URL" .git)}"
BRANCH="${3:-main}"

if [ -z "$REPO_URL" ]; then
  echo "Usage: $0 <repo-url> [target-dir] [branch]" >&2
  exit 1
fi

if [ ! -d "$TARGET_DIR/.git" ]; then
  echo "Cloning $REPO_URL into $TARGET_DIR"
  git clone --branch "$BRANCH" "$REPO_URL" "$TARGET_DIR"
else
  echo "Updating existing repo in $TARGET_DIR"
  cd "$TARGET_DIR"
  git fetch origin
  git checkout "$BRANCH"
  git pull origin "$BRANCH"
fi


#!/usr/bin/env bash

# Fail safe
set -euo pipefail

# Config
DIR_TEMPLATE="Notebook"
FILE_MAIN="Notebook.tex"
FILE_README="NotebookNeon.md"

# Usage
usage() {
    echo "Usage: $0 PROJECT"
    exit 1
}

# Argument
if [ $# -ne 1 ]; then usage; fi
PROJECT="$1"

# Guard
if [ ! -f "$DIR_TEMPLATE/$FILE_MAIN" ]; then echo "Error: Already initialized?"; exit 1; fi

# Init submodules
git submodule update --init --recursive

# Record current branch
branch=$(git branch --show-current)
# Record current remote
remote=$(git remote | head -1)

# Set template remote
git remote rename "$remote" notebook-neon

# Set template branch
git branch notebook-neon
git branch notebook-neon --set-upstream-to="notebook-neon/$branch"

# Set dummy origin
git remote add origin my-remote-repo.git

# Rename tags
for t in $(git tag -l); do git tag tp-$t $t; git tag --delete $t; done

# Rename branch to master
if [ "$branch" != "master" ]; then git branch -m "$branch" master; fi

# Update readme
git mv "README.md" "$FILE_README"
echo "# $PROJECT" > "README.md"

# Update makefile
sed -i "s/^PROJECT:=.*/PROJECT:=$PROJECT/" "$DIR_TEMPLATE/Makefile"

# Update main tex
git mv "$DIR_TEMPLATE/$FILE_MAIN" "$DIR_TEMPLATE/$PROJECT.tex"

# Update directory
git mv "$DIR_TEMPLATE/" "$PROJECT/"

# Commit and checkout to dev
git add -A
git commit -m "Init $PROJECT"
git branch --unset-upstream master
git checkout -b dev

#!/usr/bin/env bash
set -euo pipefail

DIR_TEMPLATE="Notebook"
FILE_MAIN="Notebook.tex"
FILE_README="README.md"
FILE_README_OLD="NotebookNeon.md"

usage() {
    echo "Usage: $0 PROJECT"
    exit 1
}

if [ $# -ne 1 ]; then
    usage
fi

PROJECT="$1"

if [ ! -f "$DIR_TEMPLATE/$FILE_MAIN" ]; then
    echo "Error: $DIR_TEMPLATE/$FILE_MAIN not found. Already initialized?"
    exit 1
fi

# 1. init submodules
git submodule update --init --recursive

# 2. record current branch
current=$(git branch --show-current)

# 3. rename tags
for tag in $(git tag -l); do
    git tag "tp-$tag" "$tag^{}"
    git tag -d "$tag"
done

# 4. notebook-neon branch
git branch notebook-neon

# 5. rename remote and set tracking
remote=$(git remote | head -1)
if [ -n "$remote" ]; then
    git remote rename "$remote" notebook-neon
    git branch notebook-neon --set-upstream-to="notebook-neon/$current"
fi

# 6. rename branch to master
if [ "$current" != "master" ]; then
    git branch -m "$current" master
fi

# 7. rename directory and main file
git mv "$DIR_TEMPLATE/" "$PROJECT/"
git mv "$PROJECT/$FILE_MAIN" "$PROJECT/$PROJECT.tex"

# 8. update Makefile
sed -i "s/^PROJECT:=.*/PROJECT:=$PROJECT/" "$PROJECT/Makefile"

# 9. README
git mv "$FILE_README" "$FILE_README_OLD"
echo "# $PROJECT" > "$FILE_README"

# 10. commit and checkout dev
git add -A
git commit -m "Init $PROJECT"
git checkout -b dev

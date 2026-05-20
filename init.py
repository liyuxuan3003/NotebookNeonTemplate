#!/usr/bin/env python3
import argparse
import subprocess
import sys
from pathlib import Path

DIR_TEMPLATE = "Notebook"
FILE_MAIN = "Notebook.tex"
FILE_README = "README.md"
FILE_README_OLD = "NotebookNeon.md"


def run(cmd, **kwargs):
    return subprocess.run(cmd, shell=True, check=True, **kwargs)


def main():
    parser = argparse.ArgumentParser(description="Initialize a new project from template")
    parser.add_argument("project", help="project name")
    args = parser.parse_args()

    if not Path(f"{DIR_TEMPLATE}/{FILE_MAIN}").exists():
        sys.exit(f"Error: {DIR_TEMPLATE}/{FILE_MAIN} not found. Already initialized?")

    # 1. init submodules
    run("git submodule update --init --recursive")

    # 2. record current branch
    current = subprocess.check_output(["git", "branch", "--show-current"], text=True).strip()

    # 3. rename tags
    tags = subprocess.check_output(["git", "tag", "-l"], text=True).strip().split("\n")
    for tag in tags:
        if tag:
            run(f"git tag tp-{tag} {tag}^{{}}")
            run(f"git tag -d {tag}")

    # 4. notebook-neon branch
    run("git branch notebook-neon")

    # 5. rename remote and set tracking
    remotes = subprocess.check_output(["git", "remote"], text=True).strip().split("\n")
    if remotes and remotes[0]:
        remote = remotes[0]
        run(f"git remote rename {remote} notebook-neon")
        run(f"git branch notebook-neon --set-upstream-to=notebook-neon/{current}")

    # 6. rename branch to master
    if current != "master":
        run(f"git branch -m {current} master")

    # 7. rename directory and main file
    run(f"git mv {DIR_TEMPLATE}/ {args.project}/")
    run(f"git mv {args.project}/{FILE_MAIN} {args.project}/{args.project}.tex")

    # 8. update Makefile
    run(f"sed -i 's/^PROJECT:=.*/PROJECT:={args.project}/' {args.project}/Makefile")

    # 9. README
    run(f"git mv {FILE_README} {FILE_README_OLD}")
    Path(FILE_README).write_text(f"# {args.project}\n")

    # 10. commit and checkout dev
    run("git add -A")
    run(f'git commit -m "Init {args.project}"')
    run("git checkout -b dev")


if __name__ == "__main__":
    main()

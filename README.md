# sync

This repository contains a simple standalone script for deploying code using Git.

## git_deployer.sh

`git_deployer.sh` is a helper script that deploys a Git repository or a zipped archive
into a directory chosen from a simple interactive menu. It can be used on a
server to keep a working copy in sync with a remote repository or to extract a
zip archive.

### Usage

```bash
./git_deployer.sh <repo-url-or-zip> [base-dir] [branch]
```

- `repo-url-or-zip`: Either a Git repository URL or a path to a `.zip` file to deploy.
- `base-dir`: Optional base directory that contains possible deployment folders. Defaults to the current directory.
- `branch`: Optional branch to deploy when cloning/pulling a repository. Defaults to `main`.

The script presents a numbered list (a simple dropdown) of folders found inside
`base-dir`. After choosing a folder or entering a custom path, the script will
either clone/pull the Git repository or extract the provided zip archive into
the selected directory.

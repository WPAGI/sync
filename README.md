# sync

This repository contains a simple standalone script for deploying code using Git.

## git_deployer.sh

`git_deployer.sh` is a helper script that clones or updates a repository in a target directory. It can be used on a server to keep a working copy in sync with a remote Git repository.

### Usage

```bash
./git_deployer.sh <repo-url> [target-dir] [branch]
```

- `repo-url`: URL of the Git repository to deploy.
- `target-dir`: Optional directory where the repository should be cloned or updated. Defaults to the repository name.
- `branch`: Optional branch to deploy. Defaults to `main`.

The script will clone the repository if the target directory does not exist. If it exists and contains a Git repository, it will fetch and pull the specified branch.

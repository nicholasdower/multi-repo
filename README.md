# Multi Repo

Easily interact with multiple Git repos.

## Setup

1. Clone this repository:

    ```shell
    git clone git@github.com:nicholasdower/multi-repo.git multi-repo-blah
    cd multi-repo-blah
    ```

1. Create a file named `repos.txt` with a list of Git repo paths like:

    ```shell
    nicholasdower/foo
    nicholasdower/bar
    ```

1. Clone all repos:

    ```shell
    ./clone
    ```

1. Execute a command on all repos:

    ```shell
    ./execute git status
    ```

1. See all open PRs on GitHub:

    ```shell
    ./open-prs
    ```

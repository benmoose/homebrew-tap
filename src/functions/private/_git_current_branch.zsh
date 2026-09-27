# _git_current_branch - returns the name of the current branch

builtin emulate -L zsh

if ! _git_repo; then return 1; fi

git symbolic-ref -q --short HEAD 2>/dev/null

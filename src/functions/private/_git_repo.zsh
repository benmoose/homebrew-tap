# _git_repo - Check if in a git repo

builtin emulate -L zsh

if ! git rev-parse --git-dir -q &>/dev/null; then
	if [[ "$1" != "-q" && "$1" != "-q" ]]; then _err "${funcstack[-1]}: not a git repository"; fi

	return 1
fi

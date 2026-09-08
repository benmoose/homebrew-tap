# vpr - View the pull request belonging to the current branch on GitHub

builtin emulate -L zsh

if ! _git_repo; then return 1; fi

0="${${(M)0:#/*}:-$PWD/$0}"

if ! which gh &>/dev/null; then
	_err "${0:t}: command gh not found"
	return 127
fi

setopt no_monitor
local -r msg="Opening on GitHub" err_out=$(mktemp -q -t="${0:t}")

gh pr view --web 2>"$err_out" >/dev/null &
local -r pid="$!"

trap 'kill "$pid"; rm -f "$err_out"; return 130' INT TERM
trap 'rm -f "$err_out"' EXIT

_spinner "$pid" "$msg" "$GREEN"

if ! wait "$pid" 2>/dev/null; then
	_err "$(<$err_out)"
	return 1
fi

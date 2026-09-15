# dm [<path>...] - Compare tip of current branch with main branch

builtin emulate -L zsh

if ! _git_repo; then return 1; fi

local -r main_b="$(_git_main_branch)"

setopt no_monitor
git fetch --atomic --no-tags --quiet origin "$main_b" &
local pid="$!"

_spinner "$pid" "Fetching origin..."

if ! wait "$pid" 2>/dev/null; then
	return 1
fi

git diff "origin/${main_b}...HEAD" -- "$@"

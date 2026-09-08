# gsy - (git-sync) Compare to branch at remote.

builtin emulate -L zsh
set -o pipefail

if ! _git_repo; then return 1; fi

setopt no_monitor
() {
	git fetch --no-auto-gc --no-tags --quiet origin || return $?
} &
local -r pid="$!"

_spinner "$pid" "Comparing upstream"

local -r \
	curr_b="$(_git_current_branch)" \
	head_obj="$(git rev-parse --short --verify -q HEAD)" \
	upstream_obj="$(git rev-parse --short --verify -q HEAD@{upstream})"

if [[ "$head_obj" != "$upstream_obj" ]]; then
	[[ "$1" == "-q" ]] || _err "✕ $curr_b diverges from upstream, $upstream_obj"
	return 1
fi

[[ "$1" == "-q" ]] || printf "$GREEN✓$NS $curr_b branch is up to date\n"
return 0

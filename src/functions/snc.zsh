# gsy - (git-sync) Compare to branch at remote.

builtin emulate -L zsh
set -o pipefail

if ! _git_repo; then return 1; fi

setopt no_monitor

git fetch --no-auto-gc --no-tags --quiet origin &
local -r pid="$!"
trap 'kill "$pid"; rm -f "$_err"; return 130' INT TERM

_spinner "$pid" "Comparing upstream"
wait "$pid" 2>/dev/null

local -r \
	curr_b="$(_git_current_branch)" \
	head_obj="$(git rev-parse --short --verify -q HEAD)" \
	upstream_obj="$(git rev-parse --short --verify -q HEAD@{upstream})"

if [[ "$head_obj" != "$upstream_obj" ]]; then
	[[ "$1" == "-q" ]] || printf "${RED}${BOLD}✕${NS} $curr_b diverges from upstream branch\n"
	return 1
fi

[[ "$1" == "-q" ]] || printf "${GREEN}${BOLD}✓$NS $curr_b is up to date\n"
return 0

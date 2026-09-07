#!/usr/bin/env zsh
[[ -n "$ZSH_VERSION" ]] || (
	builtin printf "fatal: expect zsh shell\n" >&2
	exit 1
)
emulate -L zsh
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"

_init() {
	local -r func_dir="${1:a:h:h}/zsh/site-functions"
	if ! [[ -d "$func_dir" ]]; then
		builtin printf \
			"%s: installed functions not found, expect directory at %s.\nTry running '%q'\n" \
			"init" "$func_dir" "brew reinstall fns" >&2
		return 1
	fi

	export -TU FPATH fpath
	if [[ -z "${fpath[(r)$HOMEBREW_PREFIX/share/zsh/site-functions]}" && -z "${fpath[(r)$func_dir]-}" ]]; then
		fpath=( "${fpath[@]}" "$func_dir" )
	fi
	builtin autoload -Uz "$func_dir"/*(:t)
}

{
	[[ "${zsh_eval_context[-1]}" == "file" ]] || return 1

	source "${0:a:h}/env.zsh"
	_init "$0"
} always {
		unset -f _init
}

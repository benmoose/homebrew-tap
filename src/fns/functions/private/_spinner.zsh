# _spinner <pid> [<msg>] - Show a spinner until the job with <pid> is finished
#
# The environment variable `SPINNER` selects the spinners.txt line number to use
# for the animation. If unset then a line is randomly chosen. SPINNER_COLOUR sets
# the animation colour.
builtin emulate -L zsh

[[ -t 1 ]] || return
[[ -n "$1" ]] || return 1

local -r data_spinners="$(brew --prefix fns)/share/fns/data/spinners.txt"
local -ar spinners=( $(<"${data_spinners:a}") )
local -ir spinner_i=$(( ${SPINNER:-RANDOM} ))
local -ar frames=( "${(ws::)spinners[$(( spinner_i % $#spinners[@] + 1 ))]}" )
local -r pid_arg="$1" msg_arg="${2-Thinking}" colour_arg="${3-${SPINNER_COLOUR:-$CYAN}}"

local GREY="$(\tput setaf 8)"
local -ar dots=(
	"${GREY}${DIM}...$NS" "${GREY}${DIM}...$NS" "${GREY}${DIM}...$NS"
	"${GREY}${DIM}...$NS" "${GREY}${DIM}...$NS" "${GREY}${DIM}...$NS"
	"$GREY.$DIM..$NS" "${GREY}${DIM}.${NS}${GREY}.$DIM.$NS" "${GREY}${DIM}..${NS}${GREY}.$NS"
)

local -i t

{
	\tput civis
	while \kill -0 "$pid_arg" &> /dev/null; do
		builtin printf "${CR}${BOLD}%s%s$NS %s%s " \
			"$colour_arg" "${frames[$(( t % $#frames[@] + 1 ))]}" \
			"$msg_arg" "${dots[$(( t/3 % $#dots[@] + 1 ))]}"
		\sleep 0.044
		((t++))
	done
} always {
	\tput cnorm
}

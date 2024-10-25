# -----------------------------------------------------------
#
# Functions to help print messages.
#
# stdOut()
# stdErr()
# stdTrace()
# stdDebug()
# stdInfo()
# stdWarn()
# stdError()
# stdFatal()
#
# -----------------------------------------------------------

# Avoid double inclusion
[[ -v libStdOutImported ]] && [[ ! -v importForce ]] && return 0
libStdOutImported=1

import libColor.bash

# -------------------------------------------------------
#
# Output text to standard out.
#
ksl::stdOut()
{
    echo -e "$*"
}

# -------------------------------------------------------
#
# Output text to standard error.
#
ksl::stdErr()
{
    echo -e "$*" 1>&2
}

# -------------------------------------------------------
#
# Output message to standard out prefaced by TRACE.
#
ksl::stdTrace()
{
    local s="${DIM}${FG_MAGENTA}[TRACE] $*${CLEAR}"
    ksl::stdOut "$s"
}

# -------------------------------------------------------
#
# Output message to standard out prefaced by DEBUG.
#
ksl::stdDebug()
{
    local s="${FG_MAGENTA}[DEBUG] $*${CLEAR}"
    ksl::stdOut "$s"
}

# -------------------------------------------------------
#
# Output message to standard out prefaced by INFO.
#
ksl::stdInfo()
{
    local s="[INFO] $*"
    ksl::stdOut "$s"
}

# -------------------------------------------------------
#
# Output message to standard out prefaced by WARN
#
ksl::stdWarn()
{
    local s="${FG_YELLOW}[WARN] $*${CLEAR}"
    ksl::stdOut "$s"
}

# -------------------------------------------------------
#
# Output message to standard error prefaced by ERROR
#
ksl::stdError()
{
    local s="${FG_RED}[ERROR] $*${CLEAR}"
    ksl::stdErr "$s"
}

# -------------------------------------------------------
#
# Output message to standard error prefaced by FATAL
#
ksl::stdFatal()
{
    local s="${BOLD}${FG_RED}[FATAL] $*${CLEAR}"
    ksl::stdErr "$s"
}

# -------------------------------------------------------

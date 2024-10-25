# Source this file to bring functions into environment
#
# stdOut()
# stdErr()
# stdInfo()
# stdWarn()
# stdError()
# stdFatal()
#
# Avoid double inclusion
[[ -v libStdOutImported ]] && [[ ! -v importForce ]] && return 0
libStdOutImported=1

# -------------------------------------------------------
#
# Output text to standard out.
#
stdOut()
{
    echo "$*"
}

# -------------------------------------------------------
#
# Output text to standard error.
#
stdErr()
{
    echo "$*" 1>&2
}

# -------------------------------------------------------
#
# Output message to standard out prefaced by INFO.
#
stdInfo()
{
    echo "[INFO] $*"
}

# -------------------------------------------------------
#
# Output message to standard out prefaced by WARN
#
stdWarn()
{
    echo "[WARN] $*"
}

# -------------------------------------------------------
#
# Output message to standard error prefaced by ERROR
#
stdError()
{
    echo "[ERROR] $*" 1>&2
}

# -------------------------------------------------------
#
# Output message to standard error prefaced by ERROR
#
stdFatal()
{
    echo "[FATAL] $*" 1>&2
}

# -------------------------------------------------------

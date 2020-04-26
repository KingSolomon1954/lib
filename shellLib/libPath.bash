# Source this file to bring function into environment
#
# Functions to manipulate shell PATH like variables.
# You know the variables with entries separated by ":" such
# as #$PATH itself.
#
# Avoid double inclusion
[[ -v libPathImported ]] && return 0
libPathImported=1

# -----------------------------------------------------------
#
# True if string $1 is contained in path style variable $2.
# 
# Returns 0 (success) if found otherwise 1 (fail).
# $1 is passed by value.
# $2 is the variable name of a path style variable
# expecting ":" separating individual elements.
#
# Example:
#     if isInPath /usr/bin PATH; then
#         echo "Yes in PATH"
#     fi
#
isInPath()
{
    [[ $# -lt 2 ]]   && return 2 # return error, missing args
    [[ ${#1} == 0 ]] && return 2 # return error, empty 1st arg
    [[ ${#2} == 0 ]] && return 2 # return error, empty 2nd arg
    local -nr v=$2
    case ":${v}:" in
        *":$1:"*) return 0;;  # Found
        *)        return 1;;  # Not found
    esac
}

# -----------------------------------------------------------
#
# Append $1 to $2 provided $1 is not already in the
# given path variable. $2 is the variable name of a path 
# style variable with ":" separating individual elements.
#
# Example:
#     appendToPath $HOME/man MANPATH
#
appendToPath ()
{
    if isInPath "${1}" ${2}; then
        return 0
    fi
    [[ $# -lt 2 ]]   && return 2 # return error, missing args
    [[ ${#1} == 0 ]] && return 2 # return error, empty 1st arg
    [[ ${#2} == 0 ]] && return 2 # return error, empty 2nd arg
    local -n v=$2
    v="${v}:$1"
    colonTrimPath $2
}

# -----------------------------------------------------------
#
# Prepend $1 to $2 provided # $1 is not already in the
# given path variable. $2 is a path style variable 
# with ":" separating individual elements.
#
# Example:
#     prependToPath $HOME/man MANPATH
#
prependToPath ()
{
    if isInPath "$1" ${2}; then
        return 0
    fi
    [[ $# -lt 2 ]]   && return 2 # return error, missing args
    [[ ${#1} == 0 ]] && return 2 # return error, empty 1st arg
    [[ ${#2} == 0 ]] && return 2 # return error, empty 2nd arg
    local -n v=$2
    v="$1:${v}"
    colonTrimPath ${2}
}

# -----------------------------------------------------------
#
# Delete $1 from $2. $2 is the name of a path style 
# variable with ":" separating individual elements.
#
# Example:
#     deleteFromPath $HOME/man MANPATH
#
deleteFromPath ()
{
    [[ $# -lt 2 ]]   && return 2 # return error, missing args
    [[ ${#1} == 0 ]] && return 2 # return error, empty 1st arg
    [[ ${#2} == 0 ]] && return 2 # return error, empty 2nd arg
    local -n v=$2
    v="${v//${1}/}"  # Sub it out
    colonTrimPath ${2}
}

# -----------------------------------------------------------
#
# Remove 1st element from $1. $1 is the name of a path style 
# variable with ":" separating individual elements.
# If $1 is empty, an empty string is returned along with a 
# an error status, othwerwise the first element of $1 up to
# the first ":" is removed from $1 and returned along with
# a status of success.
#
# Example:
#     removeFirstFromPath $HOME/man MANPATH
#
removeFirstFromPath ()
{
    [[ $# -lt 1 ]]   && return 2 # return error, missing args
    [[ ${#1} == 0 ]] && return 2 # return error, empty 1st arg
    local -n v=$1
    local result
    if isEmptyR $1; then
        echo ""
        return 1
    fi
    colonTrimPath ${2}
}

# -----------------------------------------------------------

colonTrimPath ()
{
    local -n d=${1}
    d=${d//::/:}  # Clean up double colons
    d=${d#:}      # Clean up first colon
    d=${d%:}      # Clean up trailing colon
}

# -----------------------------------------------------------

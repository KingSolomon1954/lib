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
# True if $1 is contained $2.
# Returns 0 (success) if found otherwise 1 (fail).
# $2 is a path style variable with ":" separating
# individual elements.
#
# Example:
#     if isInPath /usr/bin PATH; then
#         echo "Yes in PATH"
#     else
#         echo "Not in PATH"
#     fi
#
isInPathOld()
{
    local v=$(eval echo \$${2})
    case ":${v}:" in
        *":$1:"*) return 0;;  # Found
        *)        return 1;;  # Not found
    esac
}

isInPath()
{
#    local v=$(eval echo \$${2})
    eval local v=\$${2}
   
    case ":${v}:" in
        *":$1:"*) return 0;;  # Found
        *)        return 1;;  # Not found
    esac
}

# -----------------------------------------------------------
#
# Append $1 to $2 provided $1 is not already in the
# given path variable. $2 is a path style variable
# with ":" separating individual elements.
#
# Example:
#     appendToPath $HOME/man MANPATH
#
appendToPath ()
{
    if isInPath "$1" "$2"; then
        return 0
    fi
    eval ${2}="\$${2}:\"$1\""
    colonTrimPath ${2}
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
    if isInPath "$1" "$2"; then
        return 0
    fi
    eval ${2}="\"$1\":\$${2}"
    colonTrimPath ${2}
}

# -----------------------------------------------------------
#
# Delete $1 from $2. $2 is a path style variable
# with ":" separating individual elements.
#
# Example:
#     deleteFromPath $HOME/man MANPATH
#
deleteFromPath ()
{
    eval ${2}="\${${2}//'${1}'/}"  # Sub it out
    colonTrimPath ${2}
}

# -----------------------------------------------------------

colonTrimPath ()
{
    local d="${1}"
    eval ${d}=\${${d}//::/:}  # Clean up double colons
    eval ${d}=\${${d}#:}      # Clean up first colon
    eval ${d}=\${${d}%:}      # Clean up trailing colon
}

# -----------------------------------------------------------

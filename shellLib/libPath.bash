# Functions to manipulate shell environment PATH like variables
# with entries separated by ":" such as MANPATH and PATH itself.
#
# Normally these variables contain directory paths but they don't
# have to. Between each path element is a separator character,
# normally a colon ":" but this can be changed by setting evpSep.
#
# At the time a directory is added to a PATH variable, the
# existence of the directory can be tested for and skipped if not
# found. See envp.setDirMustExist().
#
# envp.contains(PATH, dir)
# envp.append  (PATH, dir)
# envp.prepend (PATH, dir)
# envp.delete  (PATH, dir)
# envp.setSeparator(char)
# envp.setDirMustExist("true"/"false")
#
# Source this file to bring functions into environment.

envpSep=":"
_envpDirMustExist=true

# -----------------------------------------------------------
#
# True if string $1 is contained in path style variable $2.
# 
# Returns 0 (success) if found otherwise 1 (fail).
# $1 is the name of a path style variable
# $2 is passed by value.
# expecting ":" separating individual elements.
#
# Example:
#     if envp.contains PATH "/usr/bin"; then
#         echo "Yes in PATH"
#     fi
#
envp.contains()
{
    if ! _envp.checkArgs $1 "$2"; then return 2; fi
    local -rn v=$1
    case "${envpSep}${v}${envpSep}" in
        *"${envpSep}${2}${envpSep}"*) return 0;;  # Found
        *) return 1;;  # Not found
    esac
}

# -----------------------------------------------------------
#
# Append $2 to $1 provided $2 is not already in the given path
# variable. $1 is the variable name of a path style variable with
# ":" separating individual elements. Optionally skips adding the
# fragment to the path if it doesn't exist on the file space - see
# envp.setDirMustExist()
#
# Example: envp.append MANPATH $HOME/man
#
envp.append()
{
    if ! _envp.checkArgs $1 $2; then return 2; fi
    if envp.contains $1 "$2"; then return 0; fi
    [[ "${_envpDirMustExist}" = true ]] && [[ ! -d "$2" ]] && return 0
    local -n v=$1
    v="${v}${envpSep}$2"
    _envp.colonTrimPath $1
}

# -----------------------------------------------------------
#
# Prepend $2 to $1 provided # $1 is not already in the given path
# variable. $1 is a path style variable with ":" separating
# individual elements. Optionally skips adding the fragment to the
# path if it doesn't exist on the file space
# - see envp.setDirMustExist()
#
# Example: envp.prepend MANPATH $HOME/man
#
envp.prepend()
{
    if ! _envp.checkArgs $1 $2; then return 2; fi
    if envp.contains $1 "$2"; then return 0; fi
    [[ "${_envpDirMustExist}" = true ]] && [[ ! -d "$2" ]] && return 0
    local -n v=$1
    v="$2${envpSep}${v}"
    _envp.colonTrimPath $1
}

# -----------------------------------------------------------
#
# Delete $1 from $2. $2 is the name of a path style variable with
# ":" separating individual elements.
#
# Example: envp.delete MANPATH "$HOME/man"
#
envp.delete()
{
    if ! _envp.checkArgs $1 $2; then return 2; fi
    local -n v=$1
    v="${v//${2}/}"  # Sub it out
    _envp.colonTrimPath $1
}

# -----------------------------------------------------------
#
# Delete 1st element from $1 where $1 is the name of a path style
# variable with ":" separating individual elements. Returns 0
# (true) if something was deleted, 1 (false) if nothing was
# deleted, 2 if an error.
#
# Example: envp.deleteFirst MANPATH
#
envp.deleteFirst()
{
    [[ $# -lt 1 ]]   && return 2 # return error, missing arg
    [[ ${#1} == 0 ]] && return 2 # return error, empty arg
    local -n v=$1
    [[ ${#v} == 0 ]] && return 1 # contains an empty string
    v=${v}${envpSep}     # add sentinel in case single frag
    pattern="*${envpSep}"
    v=${v#${pattern}}    # delete first including separator
    v=${v%${envpSep}}    # remove sentinel
    return 0
}

# -----------------------------------------------------------
#
# Delete last element from $1 where $1 is the name of a path style
# variable with ":" separating individual elements. Returns 0
# (true) if something was deleted, 1 (false) if nothing was
# deleted, 2 if an error.
#
# Example: envp.deleteLast MANPATH
#
envp.deleteLast()
{
    [[ $# -lt 1 ]]   && return 2 # return error, missing arg
    [[ ${#1} == 0 ]] && return 2 # return error, empty arg
    local -n v=$1
    [[ ${#v} == 0 ]] && return 1 # contains an empty string
    v=${envpSep}${v}     # add sentinel in case single frag
    pattern="${envpSep}*"
    v=${v%${pattern}}    # delete first including separator
    v=${v#${envpSep}}    # remove sentinel
    return 0
}

# -----------------------------------------------------------
#
# Supply $1 = "true" or "false"
#
# When appending or prepending a directory fragment, skip adding
# it if it doesn't exist on the file space. If you are working
# with PATH style environment variables that are not directory
# fragments, (e.g. FIGNORE), then you should set this to false for
# the scope of that call.

envp.setDirMustExist()
{
    if [ "$1" = "true" ]; then
        _envpDirMustExist=true
    else
        _envpDirMustExist=false
    fi
}

# -----------------------------------------------------------
#
# Helper function
#
_envp.checkArgs()
{
    [[ $# -ne 2 ]]   && return 2 # return error, missing args
    [[ ${#1} == 0 ]] && return 2 # return error, empty 1st arg
    [[ ${#2} == 0 ]] && return 2 # return error, empty 2nd arg
    return 0  # args are good
}

# -----------------------------------------------------------

_envp.colonTrimPath ()
{
    local -n v=${1}
    v=${v//${envpSep}${envpSep}/${envpSep}}  # Clean up double colons
    v=${v#${envpSep}}      # Clean up first colon
    v=${v%${envpSep}}      # Clean up trailing colon
}

# -----------------------------------------------------------

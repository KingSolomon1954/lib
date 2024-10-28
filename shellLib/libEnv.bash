# Functions to manipulate shell environment PATH like variables
# with entries separated by ":" such as MANPATH and PATH itself.
#
# Normally these variables contain directory paths but they don't
# have to. Between each path element is a separator character,
# normally a colon ":" but this can be changed by setting evpSep.
#
# envp.contains(PATH dir [true/false])
# envp.append  (PATH dir [true/false])
# envp.prepend (PATH dir [true/false])
# envp.delete  (PATH dir [true/false])
# envp.setSeparator(char [true/false])
#
# Source this file to bring functions into environment.

# Avoid double inclusion, but optionally allow a forcing option
# mainly for developers. For example: "source libStdOut -f"
#
[ -v libEnvImported ] && [ "$1" != "-f" ] && return
libEnvImported=true

envpSep=":"

# -----------------------------------------------------------
#
# True if path style variable $1 contains the string in $2.
#
# This is slightly different than just looking for a contained
# string as with ksl:contains(). Here the string to look for
# must exactly match and fill out to the surrounding ":" markers.
#
# Returns 0 (success) if found otherwise 1 (fail).
# $1 is the name of a path style variable and passed by value
# $2 is the string to look for
# expecting ":" separating individual elements.
#
# Example:
#     if envp.contains PATH "/usr/bin"; then
#         echo "Yes in PATH"
#     fi
#
envp.contains()
{
    [ -z $1 ]   && return 1    # Empty arg, env vars can't have spaces
    [ -z "$2" ] && return 1    # Empty arg, use quotes, support filename with spaces
    local -rn ref=$1
    [ -z "$ref" ] && return 1                 # Empty environment var

    local pat="^${2}${envpSep}"               # Front
    [[ ${ref} =~ ${pat} ]] && return 0        # Found it

    pat="${envpSep}${2}${envpSep}"            # Middle
    [[ ${ref} =~ ${pat} ]] && return 0        # Found it

    pat="${envpSep}${2}$"                     # End
    [[ ${ref} =~ ${pat} ]] && return 0        # Found it

    local pat="^${2}$"                        # Only entry
    [[ ${ref} =~ ${pat} ]] && return 0        # Found it
}

# -----------------------------------------------------------
#
# Append $2 to $1 provided $2 is not already in the given path
# variable. $1 is the variable name of a path style variable with
# ":" separating individual elements.
#
# If $3 is supplied and true, then the $2 fragment is treated as a
# filename and must must exist on the file space. If the the filename
# does not actually exist, then nothing is appended and this function
# returns false. If $3 is absent or false then, $2 is appended without
# checking for existance and returns true.

# Example: envp.append MANPATH $HOME/man true
#
# Returns true if something was appended, otherwise false.
#
envp.append()
{
    [ -z $1 ] || [ -z "$2" ] && return 1 # no args, nothing appended
    local mustExist=${3:-"false"}
    if envp.contains $1 "$2"; then return 1; fi  # Already there, no action
    [ "${mustExist}" == "true" ] && [ ! -f "$2" -a ! -d "$2" ] && return 1
    local -n ref=$1
    ref="${ref}${envpSep}$2"
    _envp.colonTrimPath $1
}

# -----------------------------------------------------------
#
# Prepend $2 to $1 provided # $1 is not already in the given path
# variable. $1 is a path style variable with ":" separating
# individual elements.
#
# If $3 is supplied and true, then the $2 fragment is treated as a
# filename and must must exist on the file space. If the the filename
# does not actually exist, then nothing is prepended and this function
# returns false. If $3 is absent or false then, $2 is prepended without
# checking for existance and returns true.
#
# Example: envp.prepend MANPATH $HOME/man true
#
envp.prepend()
{
    [ -z $1 ] || [ -z "$2" ] && return 1 # no args, nothing appended
    local mustExist=${3:-"false"}
    if envp.contains $1 "$2"; then return 1; fi  # Already there, no action
    [ "${mustExist}" == "true" ] && [ ! -f "$2" -a ! -d "$2" ] && return 1
    local -n ref=$1
    ref="$2${envpSep}${ref}"
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
    [ -z $1 ] || [ -z "$2" ] && return 1 # no args, nothing appended
    local -n ref=$1

    local match=$2            # If $2 has colons, it screws up the sub
    match=${match#${envpSep}} # Clean up leading colon if there
    match=${match%${envpSep}} # Clean up trailing colon if there

    ref="${ref//${match}/}"  # Sub it out
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
    [ -z $1 ] && return 1 # no args
    local -n ref=$1
    [ -z "$ref" ] && return 1  # Empty environment var
    ref=${ref}${envpSep}       # Add sentinel in case single frag
    pattern="*${envpSep}"
    ref=${ref#${pattern}}      # Delete first including separator
    ref=${ref%${envpSep}}      # Remove sentinel
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
    [ -z $1 ] && return 1 # no args
    local -n v=$1
    [ -z "$v" ] && return 1  # Empty environment var
    v=${envpSep}${v}     # add sentinel in case single frag
    pattern="${envpSep}*"
    v=${v%${pattern}}    # delete first including separator
    v=${v#${envpSep}}    # remove sentinel
    return 0
}

# -----------------------------------------------------------

_envp.colonTrimPath ()
{
    local -n ref=${1}
    ref=${ref//${envpSep}${envpSep}/${envpSep}}  # Clean up double colons
    ref=${ref#${envpSep}}      # Clean up first colon
    ref=${ref%${envpSep}}      # Clean up trailing colon
}

# -----------------------------------------------------------

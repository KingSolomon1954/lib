# Functions to manipulate shell environment PATH like variables
# with entries separated by ":" such as MANPATH and PATH itself.
#
# Normally these variables contain directory paths but they don't
# have to. Between each path element is a separator character,
# normally a colon ":" but this can be changed by setting evpSep.
#
# Contains the following:
#
#     ksl::envContains(PATH dir [true/false])
#     ksl::envAppend  (PATH dir [true/false])
#     ksl::envPrepend (PATH dir [true/false])
#     ksl::envDelete  (PATH dir [true/false])
#     ksl::envDeleteFirst(PATH)
#     ksl::envDeleteLast(PATH)
#     ksl::envSetSeparator(char [true/false])
#
# -----------------------------------------------------------

# Avoid double inclusion, but optionally allow a forcing option
# mainly for developers. For example: "source ksl::libStdOut -f"
#
[ -v libEnvImported ] && [ "$1" != "-f" ] && return
libEnvImported=true

envSep=":"

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
# expecting ":" separatng individual elements.
#
# Example:
#     if ksl::envContains PATH "/usr/bin"; then
#         echo "Yes in PATH"
#     fi
#
ksl::envContains()
{
    [ -z $1 ]   && return 1    # Empty arg, env vars can't have spaces
    [ -z "$2" ] && return 1    # Empty arg, use quotes, support filename with spaces
    local -rn ref=$1
    [ -z "$ref" ] && return 1                # Empty environment var

    local pat="^${2}${envSep}"               # Front
    [[ ${ref} =~ ${pat} ]] && return 0       # Found it

    pat="${envSep}${2}${envSep}"             # Middle
    [[ ${ref} =~ ${pat} ]] && return 0       # Found it

    pat="${envSep}${2}$"                     # End
    [[ ${ref} =~ ${pat} ]] && return 0       # Found it

    local pat="^${2}$"                       # Only entry
    [[ ${ref} =~ ${pat} ]] && return 0       # Found it
}

# -----------------------------------------------------------
#
# Append $2 to $1, in-place, provided $2 is not already in the
# path variable. $1 is the name of a path style variable with
# ":" separating individual elements.
#
# If $3 is supplied and true, then the $2 fragment is treated as a
# filename and must must exist on the file space. If the the filename
# does not actually exist, then nothing is appended and this function
# returns false. If $3 is absent or false then, $2 is appended without
# checking for existance and returns true.

# Example: ksl::envAppend MANPATH $HOME/man true
#
# Returns true if something was appended, otherwise false.
#
ksl::envAppend()
{
    [ -z $1 ] || [ -z "$2" ] && return 1 # no args, nothing appended
    local mustExist=${3:-"false"}
    if ksl::envContains $1 "$2"; then return 1; fi  # Already there, no action
    [ "${mustExist}" == "true" ] && [ ! -f "$2" -a ! -d "$2" ] && return 1
    local -n ref=$1
    ref="${ref}${envSep}$2"
    ksl::_envColonTrimPath $1
}

# -----------------------------------------------------------
#
# Prepend $2 to $1, in-place, provided $2 is not already in the
# path variable. $1 is the name of a path style variable with 
# ":" separating individual elements.
#
# If $3 is supplied and true, then the $2 fragment is treated as a
# filename and must must exist on the file space. If the the filename
# does not actually exist, then nothing is prepended and this function
# returns false. If $3 is absent or false then, $2 is prepended without
# checking for existance and returns true.
#
# Example: ksl::envPrepend MANPATH $HOME/man true
#
ksl::envPrepend()
{
    [ -z $1 ] || [ -z "$2" ] && return 1 # no args, nothing appended
    local mustExist=${3:-"false"}
    if ksl::envContains $1 "$2"; then return 1; fi  # Already there, no action
    [ "${mustExist}" == "true" ] && [ ! -f "$2" -a ! -d "$2" ] && return 1
    local -n ref=$1
    ref="$2${envSep}${ref}"
    ksl::_envColonTrimPath $1
}

# -----------------------------------------------------------
#
# Delete $1, in-place, from $2. $2 is the name of a path style
# variable with ":" separating individual elements.
#
# Example: ksl::envDelete MANPATH "$HOME/man"
#
ksl::envDelete()
{
    [ -z $1 ] || [ -z "$2" ] && return 1 # no args, nothing appended
    local -n ref=$1

    local match=$2            # If $2 has colons, it screws up the sub
    match=${match#${envSep}}  # Clean up leading colon if there
    match=${match%${envSep}}  # Clean up trailing colon if there

    ref="${ref//${match}/}"   # Sub it out
    ksl::_envColonTrimPath $1
}

# -----------------------------------------------------------
#
# Delete 1st element, in-place, from $1 where $1 is the name of
# a path style variable with ":" separating individual elements.
# Returns 1 on an error otherwise 0.
#
# Example: ksl::envDeleteFirst MANPATH
#
ksl::envDeleteFirst()
{
    [ -z $1 ] && return 1 # no args
    local -n ref=$1
    [ -z "$ref" ] && return 1  # Empty environment var
    ref=${ref}${envSep}        # Add sentinel in case single frag
    pattern="*${envSep}"
    ref=${ref#${pattern}}      # Delete first including separator
    ref=${ref%${envSep}}       # Remove sentinel
    return 0
}

# -----------------------------------------------------------
#
# Delete last element, in-place, from $1, where $1 is the name of 
# a path style variable with ":" separating individual elements.
# Returns 1 on an error otherwise 0.
#
# Example: ksl::envDeleteLast MANPATH
#
ksl::envDeleteLast()
{
    [ -z $1 ] && return 1 # no args
    local -n v=$1
    [ -z "$v" ] && return 1  # Empty environment var
    v=${envSep}${v}          # Add sentinel in case single frag
    pattern="${envSep}*"
    v=${v%${pattern}}        # Delete first including separator
    v=${v#${envSep}}         # Remove sentinel
    return 0
}

# -----------------------------------------------------------

ksl::_envColonTrimPath ()
{
    local -n ref=${1}
    ref=${ref//${envSep}${envSep}/${envSep}}  # Clean up double colons
    ref=${ref#${envSep}}      # Clean up first colon
    ref=${ref%${envSep}}      # Clean up trailing colon
}

# -----------------------------------------------------------

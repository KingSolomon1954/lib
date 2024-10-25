# Source this file to bring function into environment
#
# Functions to manipulate files names.
#
# Source this file to bring these functions into environment
#
# baseName()
# dirName()
#
# Avoid double inclusion
[[ -v libFilesImported ]] && [[ ! -v importForce ]] && return 0
libFilesImported=1

# -----------------------------------------------------------

ksl::baseName ()
{
    local s="${1:-}"
    s="${s%/}"
    echo ${s##*/}
}

# -----------------------------------------------------------

ksl::dirName ()
{
    # Remove any trailing '/' that doesn't have anything following it (to
    # parallel the behavior of "dirname").
    #
    local tmp1=${1%/}

    # remove last level in path
    local tmp2=${tmp1%/*}

    # If there was nothing left after removing the last level in the path,
    # the path must be to something in the root directory, so the result
    # should just be the root directory. Otherwise, if there wasn't any last
    # level, the path must be to something in the current dir, so the result
    # should just be the current dir. Otherwise,
    #
    if [ "${tmp2}" = "" ]; then
        tmp2=/
    elif [ "${tmp2}" = "${tmp1}" ]; then
        tmp2=.
    fi

    echo ${tmp2}
}

# -----------------------------------------------------------
#
#  Returns the absolute path to the script itself
#
#  $1 = supply $0 from outermost script context
#  caller: echo $(scriptDir $0)
#
ksl::scriptDir()
{
    # Note that there is no promise that $0 will work in all cases.
    # Refer to web discussions regarding finding script location.
    
    echo $(cd "$(ksl::dirName $1)" && pwd)    # absolute path to the script
}

# -----------------------------------------------------------
#
#  Returns the name of the script with suffix, if any.
#
#  $1 = supply $0 from outermost script context
#  caller: echo $(scriptFile $0)
#
ksl::scriptName()
{
    echo $(ksl::baseName "$0")
}

# -----------------------------------------------------------


# fileTrimLeft 1 
# parent, ancestor, root, stem, name
# 
#  os.path.split(path)
# 
#     Split the pathname path into a pair, (head, tail) where tail is the
#     last pathname component and head is everything leading up to
#     that. The tail part will never contain a slash; if path ends in a
#     slash, tail will be empty. If there is no slash in path, head will
#     be empty. If path is empty, both head and tail are empty. Trailing
#     slashes are stripped from head unless it is the root (one or more
#     slashes only). In all cases, join(head, tail) returns a path to the
#     same location as path (but the strings may differ). Also see the
#     functions dirname() and basename().

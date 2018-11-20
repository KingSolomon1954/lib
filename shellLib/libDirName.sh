# Source this file to bring function into environment
#
# Avoid double inclusion
[[ -v libDirNameImported ]] && return 0
libDirNameImported=1

# -----------------------------------------------------------

dirName ()
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

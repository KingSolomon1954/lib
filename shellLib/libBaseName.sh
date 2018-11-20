# Source this file to bring function into environment

# Avoid double inclusion
[[ -v libBaseNameImported ]] && return 0
libBaseNameImported=1

# -----------------------------------------------------------

baseName ()
{
    echo ${1##*/}
}

# -----------------------------------------------------------

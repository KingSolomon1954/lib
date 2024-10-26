# -----------------------------------------------------------
#
# Function to import (source) KSL library functions.
#
# Contains the following:
#
# import()
#
# -----------------------------------------------------------

# Env var tells where the KSL shell library is installed
# TODO: This needs to move out of here. User must
# define it external to this script.
#
# export KSL_BASH_LIB=$HOME/lib/shellLib

# -----------------------------------------------------------
#
# $1 the file to import
# #2 use "force" to force another import
#
# If a ksl::libxxx file has already been imported then importing it
# again is ordinarily ignored. Use the force option if you
# want to import it again anyway.
# 
# example:
#     ksl::import libFiles.bash
#     ksl::import libFiles.bash force
#
ksl::import ()
{
    # No need to check for ${KSL_BASH_LIB}
    # This function could not be running unless
    # it was already available.
    # if [ -z ${KSL_BASH_LIB} ]; then
    #    echo "[ERROR] Unable to import file: \"$1\" \"KSL_BASH_LIB\" env var must be defined"
    #    exit 1
    # fi
    if [ ! -f "${KSL_BASH_LIB}/$1" ]; then
        echo "[ERROR] Unable to import file: \"${KSL_BASH_LIB}/$1\" no such file" >&2
        exit 2
    fi
    [ $# -ge 2 ] && importForce=1
    if ! source "${KSL_BASH_LIB}/$1"; then
        echo "[ERROR] error importing: \"${KSL_BASH_LIB}/$1\"" >&2
        unset importForce
        exit 2
    fi
    unset importForce
}

# Place import() in env which allows interactive use of libs
export -f ksl::import

# -----------------------------------------------------------

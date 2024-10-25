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
export KSL_BASH_LIB=$HOME/lib/shellLib

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
    [[ -n $2 ]] && importForce=1
    if ! source "${KSL_BASH_LIB}/$1"; then
        if [ ! -d "${KSL_BASH_LIB}" ]; then
            echo "[ERROR] KSL_BASH_LIB ${KSL_BASH_LIB} does not exist"
            unset importForce
            exit 1
        fi
    fi
    unset importForce
}

# Place import() in env which allows interactive use of libs
export -f ksl::import

# -----------------------------------------------------------

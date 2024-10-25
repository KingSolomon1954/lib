# -----------------------------------------------------------
#
# Env var tells where the KSL shell library is installed
#
export KSL_BASH_LIB=$HOME/lib/shellLib

# -----------------------------------------------------------
#
# Function to source library functions
#
# $1 the file to import
# #2 use "force" to force another import
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

success=0
fail=1

# Place import() function in env which allows interactive use of libs
export -f ksl::import

# -----------------------------------------------------------

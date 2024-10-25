# Source this file to bring function into environment
#
# Functions to manipulate shell PATH like variables.
# You know the variables with entries separated by ":" such
# as #$PATH itself.
#
# Avoid double inclusion
[[ -v libConditionWait ]] && return 0
libConditionWait=1

# -----------------------------------------------------------
#
# Blocks until the provided condition becomes true
#
# Arguments:
#  $1: message indicating what conditions is being waited
#      for (e.g. 'config to be written')
#  $2: a string representing an eval'able condition.  When
#      eval'd it should not output to stdout or stderr.
#  $3: optional timeout in seconds.  If not provided, waits forever.
#
# Returns:
#    1 if the condition is not met before the timeout
#
function util::wait-for-condition() {
    local msg=$1
    # condition should be a string that can be eval'd.
    local condition=$2
    local timeout=${3:-}

    local start_msg="Waiting for ${msg}"
    local error_msg="[ERROR] Timeout waiting for ${msg}"

    local counter=0
    while ! eval ${condition}; do
        if [[ "${counter}" = "0" ]]; then
            echo -n "${start_msg}"
        fi

        if [[ -z "${timeout}" || "${counter}" -lt "${timeout}" ]]; then
            counter=$((counter + 1))
            if [[ -n "${timeout}" ]]; then
                echo -n '.'
            fi
              sleep 1
          else
              echo -e "\n${error_msg}"
              return 1
          fi
    done

    if [[ "${counter}" != "0" && -n "${timeout}" ]]; then
        echo ' done'
    fi
}
readonly -f util::wait-for-condition

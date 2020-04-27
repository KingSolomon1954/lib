# Source this file to bring function into environment
#
# Avoid double inclusion
[[ -v libStdFlagsImported ]] && return 0
libStdFlagsImported=1

set -o errexit    # exit when a command fails
set -o pipefail   # exit when a pipe fails
set -o nounset    # exit when script uses undelcared variable

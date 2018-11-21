# Source this file to bring function into environment
#
# Avoid double inclusion
[[ -v libStdFileVarsImported ]] && return 0
libStdFileVarsImported=1

import libBaseName.sh

# -----------------------------------------------------------

# Set file variables to where the script resides.
#
# Attempts to set these variables to where the script resides.
# Note that there is no promise that $0 will work in all cases.
# Refer to web discussions regarding finding script location.

_scriptDir=$(cd "$(dirName $0)" && pwd)
_scriptFile="$(baseName "$0")"
_scriptBase="${_scriptFile%.*}"

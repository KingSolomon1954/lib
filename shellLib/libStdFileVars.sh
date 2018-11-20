# Source this file to bring function into environment
#
# Avoid double inclusion
[[ -v libStdFileVarsImported ]] && return 0
libStdFileVarsImported=1

import libDirName.sh
import libBaseName.sh

# -----------------------------------------------------------

# Set file variables useful in many scripts

_scriptDir=$(cd "$(dirName $0)" && pwd)
_scriptFile="$(baseName "$0")"
_scriptBase="${_scriptFile%.*}"

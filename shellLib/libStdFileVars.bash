# Source this file to bring function into environment
#
# Provide shell variables to where the script resides.
#
# -----------------------------------------------------------
#
# Avoid double inclusion
#
[[ -v libStdFileVarsImported ]] && return 0
libStdFileVarsImported=1

import libBaseName.sh
import libDirName.sh

# -----------------------------------------------------------

# Note that there is no promise that $0 will work in all cases.
# Refer to web discussions regarding finding script location.

scriptDir=$(cd "$(dirName $0)" && pwd)    # absolute path to the script
scriptFile="$(baseName "$0")"             # name of script file with suffix
scriptBase="${_scriptFile%.*}"            # name of script file without suffix

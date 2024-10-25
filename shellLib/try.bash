#!/usr/bin/env bash

source ${KSL_BASH_LIB}/libImport.bash

import libFiles.bash
import libStdOut.bash

ksl::stdTrace "Trying out color messages"
ksl::stdDebug "Trying out color messages"
ksl::stdInfo  "Script: $(ksl::scriptName $0) ($(ksl::scriptDir $0))"
ksl::stdWarn  "Trying out color messages"
ksl::stdError "Trying out color messages"
ksl::stdFatal "Trying out color messages"

#!/usr/bin/env bash

testIt()
{
    if [ -z "${KSL_USE_COLOR}" ]; then
        echo "KSL_USE_COLOR: not defined (using -z)"
    fi
    echo "KSL_USE_COLOR: ${KSL_USE_COLOR}"

    [[ ${KSL_USE_COLOR} -eq 0 ]] && echo "KSL_USE_COLOR (stay away) as integer 0 equals true"
    [[ ${KSL_USE_COLOR} -eq 1 ]] && echo "KSL_USE_COLOR (stay away) as integer 1 equals true"
    [[ ${KSL_USE_COLOR} -eq true ]] && echo "KSL_USE_COLOR (stay away) as integer true equals true"
    [[ ${KSL_USE_COLOR} -eq false ]] && echo "KSL_USE_COLOR (stay away) as integer false equals false"
    [[ "${KSL_USE_COLOR}" == "true" ]] && echo "KSL_USE_COLOR (use this) as string equals true"
    [[ "${KSL_USE_COLOR}" == "false" ]] && echo "KSL_USE_COLOR (use this) as string equals false"

    if ${KSL_USE_COLOR}; then
        echo "{KSL_USE_COLOR} tests true"
    else
        echo "{KSL_USE_COLOR} tests false"
    fi
}

KSL_USE_COLOR=true
testIt

echo; echo

KSL_USE_COLOR=false
testIt

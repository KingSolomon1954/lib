#!/bin/sh
#
# FILE
#     scriptName - briefly describe application of script
#
# SYNOPSIS
#     scriptName [-a] [-b <text>] file ...
#
# OPTIONS
#     [-a] = description of -a functionality
#     [-b <text>] = description of -b functionality
#     <file> ... = description of <file> ... functionality
#
# DESCRIPTION
#     If there is a man page for the script, a reference can be made to the
#     man page. Otherwise, describe the application of the script here.
#
# EXAMPLE
#     If there is a man page for the script, a reference can be made to the
#     man page. Otherwise, an example of script usage can be provided here.
# 
# ENVIRONMENT
#     If there is a man page for the script, a reference can be made to the
#     man page. Otherwise, describe any relevant environment variables here.
#
# BUGS
#     If there is a man page for the script, a reference can be made to the
#     man page. Otherwise, describe any known bugs here.
#
# -----------------------------------------------------------

# Global variables. Actually, in a shell script, all variables in all
# functions are global, so be careful. The variables set here are those
# variables which are intended to be accessed globally.
#
cmdName=`basename $0`
tmpFile="/tmp/${cmdName}.$$"
resourceReserved=false

# Main body of script. 
#
main ()
{
    # set to call exitClean on SIGINT(2) or SIGTERM(15)
    trap 'exitClean 1' 2 15

    # parse arguments
    while [ $# -ne 0 ]; do

        case $1 in
        -help)
            usage
            exitClean 0;;
        -a)
            # example of handling an option which doesn't require an argument
            specdA=1;;
        -b)
            # example of handling an option which requires an argument
            if [ $# -lt 2 ]; then
                usage No argument specified along with \"$1\" option.
                exitClean 1
            fi
            bArg=$2
            shift;;
        -*)
            usage Invalid option \"$1\".
            exitClean 1;;
        *)
            # example of handling non-flag arguments which may be repeated
            if [ "${files}" = "" ]; then
                files="$1"
            else
                files="${files} $1"
            fi;;
        esac

        shift
    done

    if [ "${files}" = "" ]; then
        files=...
    fi

    worktreetop=/home/howie/worktree
    #worktreetop=$(findworktreetop)
    doSync

    # clean up and exit
    exitClean 0
}

# ---------------------------------------------

doSync ()
{
    tgts=$(expandCompoundTgts)

    for t in ${tgts}; do
        if isPredefinedTgt ${t}; then
            doPredefinedTgt ${t}
        else
            echo p4 sync ${t}
        fi
    done
}

# ---------------------------------------------
#
# Returns a list of targets with the compound
# targets expanded.
#
expandCompoundTgts ()
{
    local sgsTgts="dlc ipe mcd nms"
    local snccTgts="bng tag tts kms nms"

    for t in ${files}; do
        case ${t} in
        sgs)  tgts="${tgts} ${sgsTgts}";;
        sncc) tgts="${tgts} ${snccTgts}";;
        *) tgts="${tgts} ${t}";;
        esac
    done

    for t in ${tgts}; do
        echo ${t}
    done | sort -u    
}

# ---------------------------------------------
#
# Returns success if the argument matches
# one of the predefined targets.
#
isPredefinedTgt ()
{
    local rv=1
    case $1 in
    dlc)  rv=0;;
    ipe)  rv=0;;
    esac
    return ${rv}
}

# ---------------------------------------------

doPredefinedTgt ()
{
    echo cd ${worktreetop}
    ptp=$(predefinedTgtPath $1)
    echo p4 sync ${ptp} \(special\)
    echo cd -
}

# ---------------------------------------------
#
# Returns a path to the predefined target
# relative to the top of the worktree.
#
predefinedTgtPath ()
{
    case $1 in
    dlc)  echo sw/main/src/dlc/... ;;
    ipe)  echo sw/main/src/ipe/... ;;
    *)    echo "Programming error - unknown tgt: $1" ;;
    esac
}

# ---------------------------------------------

# Clean up any resources that were reserved (temporary files, etc), then exit
# with the passed exit status.
#
exitClean ()
{
    # example of making sure a temporary file is deleted
    rm -f ${tmpFile}

    # example of checking if a resource was reserved, and if so, freeing it
    if [ "${resourceReserved}" = "true" ]; then
        : #logic to free resource would replace this line
    fi

    # exit with passed exit status (if not specified, default to 1)
    exit ${1:-1}
}

# Show the passed message (if a message was specified),
# followed by the usage extracted from the SYNOPSIS and
# OPTIONS sections in the prologue at the top of this
# script.
#
usage ()
{
    # first output any passed message
    if [ $# -ne 0 ]; then stdErr "$*"; fi

    # Extract usage from prologue at top of script and output it. The first
    # "sed" outputs from the first line up to the "# DESCRIPTION" line (to
    # limit how much of the script is parsed, for speed). The second "sed"
    # extracts everything between SYNOPSIS and DESCRIPTION. The third "sed"
    # eliminates the lines which begin with SYNOPSIS, DESCRIPTION, and
    # OPTIONS. The last "sed" strips any '#' off the beginning of each
    # line and eliminates blank lines.
    #
    stdErr "Usage:"
    sed "/^# *DESCRIPTION/q" $0 | \
        sed -n "/^# *SYNOPSIS/,/^# *DESCRIPTION/p" | \
        sed -e "/^# *SYNOPSIS/d" -e "/^# *DESCRIPTION/d" -e "/^# *OPTIONS/d" | \
        sed -e "s/^#//"  -e "/^ *$/d" 1>&2
}

# Output text to standard out.
#
stdOut ()
{
    echo "$*"
}

# Output text to standard error.
#
stdErr ()
{
    echo "$*" 1>&2
}

# Invoke main body of script (never returns). This must appear at the bottom
# of the script, so all functions which main() calls are visible to main().
#
if [ $# != 0 ]; then
    main "$@"
else
    main
fi

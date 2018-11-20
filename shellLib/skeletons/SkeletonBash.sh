#!/usr/bin/env bash
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

    # example of checking for any required results from argument parsing
    if [ "${files}" = "" ]; then
        usage No files specified.
        exitClean 1
    fi

    # example of temporary file creation
    touch ${tmpFile}

    # Example of how a flag can be set to tell exitClean() a resource was
    # reserved which will require cleanup. If we don't reach this point in
    # the script due to an error or something, the flag won't be set, so
    # exitClean() won't attempt to clean up a resource that wasn't reserved.
    #
    : #logic to reserve resource would replace this line
    resourceReserved=true

    # examples of referencing specified arguments
    if [ "${specdA}" != "" ]; then
        stdOut Specified \"-a\".
    fi
    if [ "${bArg}" != "" ]; then
        stdOut Specified \"-b ${bArg}\".
    fi
    stdOut Specified files \"${files}\".

    # clean up and exit
    exitClean 0
}

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

#!/usr/bin/env bash
#
# FILE
#     scriptName - briefly describe application of script
#
# SYNOPSIS
#     scriptName [options...] <file> ...
#
# OPTIONS
#     -h, --help               show this help
#     -v, --version            display version and exit
#     -p, --pretty-print       set pretty printing
#     -V, --verbose <level>    set verbosity to <level>
#
# DESCRIPTION
#     If there is a man page for the script, a reference can
#     be made to the man page. Otherwise, describe the application
#     of the script here.
#
# EXAMPLE
#     If there is a man page for the script, a reference can be
#     made to the man page. Otherwise, an example of script usage
#     can be provided here.
#
# ENVIRONMENT
#     If there is a man page for the script, a reference can be
#     made to the man page. Otherwise, describe any relevant
#     environment variables here.
#
# BUGS
#     If there is a man page for the script, a reference can be
#     made to the man page. Otherwise, describe any known bugs here.
#
# -----------------------------------------------------------

# Bring in KSL bash library
if ! source ${KSL_BASH_LIB}/libImport.bash; then
    echo "[ERROR] \"KSL_BASH_LIB\" env var is not defined"
    exit 1
fi

ksl::import libFiles.bash
ksl::import libStrings.bash
ksl::import libStdOut.bash

# Global variables. Actually, in a shell script, all variables in all
# functions are global, so be careful. The variables set here are those
# variables which are intended to be accessed globally.
#
declare -r scriptVersion="1.0.0"
declare -r scriptName=$(ksl::trimRight "$(ksl::scriptName)" ".bash")

tmpFile="/tmp/${scriptName}.$$"
resourceReserved="no"
verbosityLevel=0
prettyPrint="no"
filesToProcess=

# -----------------------------------------------------------
#
# Main body of script.
#
main()
{
    # Set to call exitClean on SIGINT(2) or SIGTERM(15)
    trap 'exitClean 1' 2 15

    commandLine "$@"  # Parse command line
    showConfig        # Review config
    processFiles      # Perform the work
    exitClean 0       # Clean up and exit
}

# -----------------------------------------------------------
#
# After parsing command line, args are available as globals
#
commandLine()
{
    while [ $# -ne 0 ]; do        # parse arguments
        case $1 in
        -h|--help)
            usage
            exitClean 0;;
        -v|--version)
            printVersion
            exitClean 0;;
        -p|--pretty-print)
            # Example of handling an option which doesn't require an argument
            prettyPrint="yes";;
        -verbose|--verbose)
            # Example of handling an option which requires an argument
            if [ $# -lt 2 ]; then
                usage No argument specified along with \"$1\" option.
                exitClean 1
            fi
            verbosityLevel=$2
            shift;;
        -*)
            usage Invalid option \"$1\".
            exitClean 1;;
        *)
            # Example of handling non-flag arguments which may be repeated
            filesToProcess="${filesToProcess} $1";;
        esac
        shift
    done

    if [ -z "${filesToProcess}" ]; then
        usage Must specify at least one file to process.
        exitClean 1
    fi

    if [[ "${verbosityLevel}" -gt 3 ]]; then
        usage Bad verbosity level: ${verbosityLevel}, valid values [0..3]
        exitClean 1
    fi
}

# -----------------------------------------------------------

printVersion()
{
    ksl::stdOut "${scriptName} v${scriptVersion}"
}

# -----------------------------------------------------------

showConfig()
{
    ksl::stdDebug "prettyPrint: ${prettyPrint}"
    ksl::stdDebug "verbosityLevel: ${verbosityLevel}"
    ksl::stdDebug "fileToProcess: ${filesToProcess}"
}

# -----------------------------------------------------------
#
# Clean up any resources that were reserved (temporary files, etc),
# then exit with the passed exit status.
#
exitClean()
{
    # Example of making sure a temporary file is deleted
    rm -f ${tmpFile}

    # Example of checking if a resource was reserved, and if so, freeing it
    if [ "${resourceReserved}" == "yes" ]; then
        : #logic to free resource would replace this line
    fi

    # Exit with passed exit status (if not specified, default to 0)
    exit ${1:-0}
}

# -----------------------------------------------------------
#
# Show the passed message (if a message was specified),
# followed by the usage extracted from the SYNOPSIS and
# OPTIONS sections in the prologue at the top of this
# script.
#
usage()
{
    # First output any passed message
    if [ $# -ne 0 ]; then ksl::stdErr "$*"; fi

    # Extract usage from prologue at top of script and output it. The first
    # "sed" outputs from the first line up to the "# DESCRIPTION" line (to
    # limit how much of the script is parsed, for speed). The second "sed"
    # extracts everything between SYNOPSIS and DESCRIPTION. The third "sed"
    # eliminates the lines which begin with SYNOPSIS, DESCRIPTION, and
    # OPTIONS. The last "sed" strips any '#' off the beginning of each
    # line and eliminates blank lines.
    #
    ksl::stdErr "Usage:"
    sed "/^# *DESCRIPTION/q" $0 | \
        sed -n "/^# *SYNOPSIS/,/^# *DESCRIPTION/p" | \
        sed -e "/^# *SYNOPSIS/d" -e "/^# *DESCRIPTION/d" -e "/^# *OPTIONS/d" | \
        sed -e "s/^#//"  -e "/^ *$/d" 1>&2
}

# -----------------------------------------------------------

processFiles()
{
    for f in ${filesToProcess}; do
        ksl::stdInfo "Processing file: ${f}"
        if [ "${prettyPrint}" == "yes" ]; then
            ksl::stdDebug "Pretty formatting file: ${f}"
        fi
    done
}

# -----------------------------------------------------------

# Invoke main body of script (never returns). This must appear
# at the bottom of the script, so all functions which main()
# calls are visible to main().
#

main "$@"

# -----------------------------------------------------------

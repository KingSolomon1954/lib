# Source this file to bring function into environment
#
# Avoid double inclusion
[[ - v libUsageImported ]] && return 0
libUsageImported=1

# -------------------------------------------------------
#
# Output usage from section in prolog.
#
usage()
{
    # output prolog (up to first line that doesn't begin with #)
    /usr/bin/sed "/^[^#]*$/q" $0
}

# -----------------------------------------------------------

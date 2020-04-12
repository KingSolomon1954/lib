# Source this file to bring functions into environment
#
# Functions to manipulate shell strings.
#
# Avoid double inclusion
[[ -v libStringImported ]] && return 0
libStringImported=1

# -----------------------------------------------------------
#
# Returns the number of characters in string.
# Example:
#     x=$(strlen dinosaur)
#
strlen ()
{
    local d="${1}"
    echo "${#d}"
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are alphanumeric as
# defined by POSIX standard.
#
isAlphNum()
{
    local pat='^[[:alnum:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are alpha as defined by
# POSIX standard.
#
isAlpha()
{
    local pat='^[[:alpha:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are ASCII chars as defined
# by POSIX standard.
#
# ASCII is not currently working. Need to investigate.
#
# isAscii()
# {
#     local pat='^[[:ascii:]]+$'
#     [[ ${1} =~ ${pat} ]]
# }

# -----------------------------------------------------------
#
# Return true if all characters in the string are blank as
# defined by POSIX standard.
#
isBlank()
{
    local pat='^[[:blank:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are control characters as
# defined by POSIX standard.
#
isCntrl()
{
    local pat='^[[:cntrl:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are digits as defined by
# POSIX standard. Note that "+" "-" "." are not digits.
#
isDigit()
{
    local pat='^[[:digit:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are in the graph class
# (displayable on a screen) as defined by POSIX standard.
#
isGraph()
{
    local pat='^[[:graph:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are lowercase as
# defined by POSIX standard.
#
isLower()
{
    local pat='^[[:lower:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if the string forms a valid integer meaning all digits
# with an optional preceding +/-. Does not check for length.
#
isInteger()
{
    local pat='^[+-]?[[:digit:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are printable as
# defined by POSIX standard.
#
isPrint()
{
    local pat='^[[:print:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are punctuations as
# defined by POSIX standard.
#
isPunct()
{
    local pat='^[[:punct:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are spaces as
# defined by POSIX standard.
#
isSpace()
{
    local pat='^[[:space:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are uppercase as
# defined by POSIX standard.
#
isUpper()
{
    local pat='^[[:upper:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
# Return true if all characters in the string are considered a
# word - containing only letters, digits, and the character _.
#
# isWord is not currently working. Need to investigate.
#
# isWord()
# {
#     local pat='^[[:word:]]+$'
#     [[ ${1} =~ ${pat} ]]
# }

# -----------------------------------------------------------
#
# Return true if all characters in the string are valid hexadecimal
# digits.
#
isXdigit()
{
    local pat='^[[:xdigit:]]+$'
    [[ ${1} =~ ${pat} ]]
}

# -----------------------------------------------------------
#
#     local -i rv=$?
#     if (( ${rv} > 1 )); then
#         echo "bad regex syntax"
#     fi
#     return ${rv}
#
# -----------------------------------------------------------


# 
#  -- Method: str.isnumeric ()
# 
#      Return true if all characters in the string are numeric characters,
#      and there is at least one character, false otherwise.  Numeric
#      characters include digit characters, and all characters that have
#      the Unicode numeric value property, e.g.  U+2155, VULGAR FRACTION
#      ONE FIFTH. Formally, numeric characters are those with the property
#      value Numeric_Type=Digit, Numeric_Type=Decimal or
#      Numeric_Type=Numeric.
# 
# -- Method: str.isspace ()
# 
#      Return true if there are only whitespace characters in the string
#      and there is at least one character, false otherwise.  Whitespace
#      characters are those characters defined in the Unicode character
#      database as “Other” or “Separator” and those with bidirectional
#      property being one of “WS”, “B”, or “S”.
# 
#  -- Method: str.isupper ()
# 
#      Return true if all cased characters (2) in the string are uppercase
#      and there is at least one cased character, false otherwise.
# 
#  -- Method: str.islower ()
# 
#      Return true if all cased characters (1) in the string are lowercase
#      and there is at least one cased character, false otherwise.
# 
#  -- Method: str.startswith (prefix[, start[, end]])
# 
#      Return ‘True’ if string starts with the `prefix', otherwise return
#      ‘False’.  `prefix' can also be a tuple of prefixes to look for.
#      With optional `start', test string beginning at that position.
#      With optional `end', stop comparing string at that position.
# 
#  -- Method: str.endswith (suffix[, start[, end]])
# 
#      Return ‘True’ if the string ends with the specified `suffix',
#      otherwise return ‘False’.  `suffix' can also be a tuple of suffixes
#      to look for.  With optional `start', test beginning at that
#      position.  With optional `end', stop comparing at that position.
# 
#  -- Method: str.find (sub[, start[, end]])
# 
#      Return the lowest index in the string where substring `sub' is
#      found within the slice ‘s[start:end]’.  Optional arguments `start'
#      and `end' are interpreted as in slice notation.  Return ‘-1’ if
#      `sub' is not found.
# 
#  -- Method: str.rfind (sub[, start[, end]])
# 
#      Return the highest index in the string where substring `sub' is
#      found, such that `sub' is contained within ‘s[start:end]’.
#      Optional arguments `start' and `end' are interpreted as in slice
#      notation.  Return ‘-1’ on failure.
# 
# ------------------------------------------
# 
#  -- Method: str.lower ()
# 
#      Return a copy of the string with all the cased characters (3)
#      converted to lowercase.
# 
#  -- Method: str.upper ()
# 
#      Return a copy of the string with all the cased characters (4)
#      converted to uppercase.  Note that ‘s.upper().isupper()’ might be
#      ‘False’ if ‘s’ contains uncased characters or if the Unicode
#      category of the resulting character(s) is not “Lu” (Letter,
#      uppercase), but e.g.  “Lt” (Letter, titlecase).
# 
#      The uppercasing algorithm used is described in section 3.13 of the
#      Unicode Standard.
# 
# -- Method: str.capitalize ()
# 
#      Return a copy of the string with its first character capitalized
#      and the rest lowercased.
# 
#  -- Method: str.strip ([chars])
# 
#      Return a copy of the string with the leading and trailing
#      characters removed.  The `chars' argument is a string specifying
#      the set of characters to be removed.  If omitted or ‘None’, the
#      `chars' argument defaults to removing whitespace.  The `chars'
#      argument is not a prefix or suffix; rather, all combinations of its
#      values are stripped:
# 
#           >>> '   spacious   '.strip()
#           'spacious'
#           >>> 'www.example.com'.strip('cmowz.')
#           'example'
# 
#      The outermost leading and trailing `chars' argument values are
#      stripped from the string.  Characters are removed from the leading
#      end until reaching a string character that is not contained in the
#      set of characters in `chars'.  A similar action takes place on the
#      trailing end.  For example:
# 
#           >>> comment_string = '#....... Section 3.2.1 Issue #32 .......'
#           >>> comment_string.strip('.#! ')
#           'Section 3.2.1 Issue #32'
# 
#  -- Method: str.lstrip ([chars])
# 
#      Return a copy of the string with leading characters removed.  The
#      `chars' argument is a string specifying the set of characters to be
#      removed.  If omitted or ‘None’, the `chars' argument defaults to
#      removing whitespace.  The `chars' argument is not a prefix; rather,
#      all combinations of its values are stripped:
# 
#           >>> '   spacious   '.lstrip()
#           'spacious   '
#           >>> 'www.example.com'.lstrip('cmowz.')
#           'example.com'
# 
#  -- Method: str.rstrip ([chars])
# 
#      Return a copy of the string with trailing characters removed.  The
#      `chars' argument is a string specifying the set of characters to be
#      removed.  If omitted or ‘None’, the `chars' argument defaults to
#      removing whitespace.  The `chars' argument is not a suffix; rather,
#      all combinations of its values are stripped:
# 
#           >>> '   spacious   '.rstrip()
#           '   spacious'
#           >>> 'mississippi'.rstrip('ipz')
#           'mississ'
# 
#  -- Method: str.replace (old, new[, count])
# 
#      Return a copy of the string with all occurrences of substring `old'
#      replaced by `new'.  If the optional argument `count' is given, only
#      the first `count' occurrences are replaced.
# 
# :docstring strtrunc:
# # Usage: strtrunc $n $s1 {$s2} {$...}
# #
# # Used by many functions like strncmp to truncate arguments for comparison.
# # Echoes the first n characters of each string s1 s2 ... on stdout. 
# #:end docstring:
# 
# ###;;;autoload
# function strtrunc ()
# {
#     n=$1 ; shift
#     for z; do
#         echo "${z:0:$n}"
#     done
# }
# 
# 
#  -- Method: str.partition (sep)
# 
#      Split the string at the first occurrence of `sep', and return a
#      3-tuple containing the part before the separator, the separator
#      itself, and the part after the separator.  If the separator is not
#      found, return a 3-tuple containing the string itself, followed by
#      two empty strings.
# 
#  -- Method: str.split (sep=None, maxsplit=-1)
# 
#      Return a list of the words in the string, using `sep' as the
#      delimiter string.  If `maxsplit' is given, at most `maxsplit'
#      splits are done (thus, the list will have at most ‘maxsplit+1’
#      elements).  If `maxsplit' is not specified or ‘-1’, then there is
#      no limit on the number of splits (all possible splits are made).
# 
# #:docstring strstr:
# # Usage: strstr s1 s2
# # 
# # Strstr echoes a substring starting at the first occurrence of string s2 in
# # string s1, or nothing if s2 does not occur in the string.  If s2 points to
# # a string of zero length, strstr echoes s1.
# #:end docstring:
# 
# ###;;;autoload
# function strstr ()
# {
#     # if s2 points to a string of zero length, strstr echoes s1
#     [ ${#2} -eq 0 ] && { echo "$1" ; return 0; }
# 
#     # strstr echoes nothing if s2 does not occur in s1
#     case "$1" in
#     *$2*) ;;
#     *) return 1;;
#     esac
# 
#     # use the pattern matching code to strip off the match and everything
#     # following it
#     first=${1/$2*/}
# 
#     # then strip off the first unmatched portion of the string
#     echo "${1##$first}"
# }
# 
#  -- Method: str.zfill (width)
# 
#      Return a copy of the string left filled with ASCII ‘'0'’ digits to
#      make a string of length `width'.  A leading sign prefix
#      (‘'+'’/‘'-'’) is handled by inserting the padding `after' the sign
#      character rather than before.  The original string is returned if
#      `width' is less than or equal to ‘len(s)’.
# 
#      For example:
# 
#           >>> "42".zfill(5)
#           '00042'
#           >>> "-42".zfill(5)
#           '-0042'
# 
# 

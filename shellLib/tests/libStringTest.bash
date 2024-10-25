#!/usr/bin/env bash

# set -o xtrace   # for debugging

ksl::import libString.bash

# -----------------------------------------------------------

test_strlen()
{
    assert_equals "8" "$(strlen dinosaur)"      # normal string
    assert_equals "9" "$(strlen 'dino saur')"   # normal string
    assert_equals "0" "$(strlen )"              # test no args
    assert_equals "0" "$(strlen '')"            # test zero length string

    local DINO="dinosaur"
    assert_equals "8" "$(strlenR DINO)"         # normal string
    DINO="dino saur"
    assert_equals "9" "$(strlenR DINO)"         # normal string
    assert_equals "0" "$(strlenR )"             # test no args
    assert_equals "0" "$(strlenR EMPTY)"        # test empty named string
    assert_equals "0" "$(strlenR "")"           # test zero length string
}

test_isEmpty()
{
    assert "isEmpty ''"
    assert_fails "isEmpty 'dinosaur' "
    assert "isEmpty "

    local DINO="dinosaur"
    assert "isEmptyR '' "
    assert_fails "isEmptyR 'DINO' "
    assert "isEmptyR "
    DINO=""
    assert "isEmptyR 'DINO' "
    DINO=
    assert "isEmptyR 'DINO' "
}

test_isAlphNum()
{
    assert "isAlphNum '12345' "
    assert "isAlphNum 'abcde' "
    assert "isAlphNum '1a2b3c4d5e' "
    assert_fails "isAlphNum "
    assert_fails "isAlphNum '#%@' "
    assert_fails "isAlphNum 'I am Spartacus' "
}

test_isAlpha()
{
    assert "isAlpha 'abcde' "
    assert_fails "isAlpha "
    assert_fails "isAlpha '12345'"
    assert_fails "isAlpha 'a2b3c4d5e'"
    assert_fails "isAlpha '#%@'"
    assert_fails "isAlpha 'I am Spartacus'"
}

test_isAscii()
{
    # assert "isAscii '\20'"
    assert_fails "isAscii 'abcde'"
    assert_fails "isAscii '12345'"
    assert_fails "isAscii"
    assert_fails "isAscii '#%@'"
    assert_fails "isAscii 'I am Spartacus'"
}

test_isBlank()
{
    local x="           "
    assert "isBlank '$x'"
    assert_fails "isBlank 'abcde'"
    assert_fails "isBlank '12345'"
    assert_fails "isBlank"
    assert_fails "isBlank '#%@'"
    assert_fails "isBlank 'I am Spartacus'"
}

test_isCntrl()
{
    local x=$'\e\a\t\r\n'
    assert "isCntrl '$x'"
    assert_fails "isCntrl 'abcde'"
    assert_fails "isCntrl '12345'"
    assert_fails "isCntrl"
    assert_fails "isCntrl '#%@'"
    assert_fails "isCntrl 'I am Spartacus'"
}

test_isDigit()
{
    assert "isDigit '12345'"
    assert "isDigit '0'"
    assert_fails "isDigit"
    assert_fails "isDigit '-12345'"
    assert_fails "isDigit '+12345'"
    assert_fails "isDigit '#%@'"
    assert_fails "isDigit 'I am Spartacus'"
}

test_isGraph()
{
    assert "isGraph '12345'"
    assert "isGraph '0'"
    assert "isGraph '-12345'"
    assert "isGraph '+12345'"
    assert "isGraph '#%@'"
    assert_fails "isGraph"
    assert_fails "isGraph '\t   '"
    assert_fails "isGraph 'I am Spartacus'"
}

test_isInteger()
{
    # valid integers
    assert "isInteger '12345'"
    assert "isInteger '+12345'"
    assert "isInteger '-12345'"
    assert "isInteger '0'"

    # bad integers
    assert_fails "isInteger "
    assert_fails "isInteger '+'"
    assert_fails "isInteger '-'"
    assert_fails "isInteger '.'"
    assert_fails "isInteger 'dinosaur'"
    assert_fails "isInteger '+d'"
    assert_fails "isInteger '123a45'"
    assert_fails "isInteger '123-45'"
    assert_fails "isInteger '123+45'"
    assert_fails "isInteger '123.45'"
    assert_fails "isInteger '#%@'"
    assert_fails "isInteger 'I am Spartacus'"
}

test_isNumber()
{
    # valid numerics
    assert "isNumber '1'"
    assert "isNumber '12345'"
    assert "isNumber '+12345'"
    assert "isNumber '-12345'"
    assert "isNumber '0'"
    assert "isNumber '0.0'"
    assert "isNumber '+0.0'"
    assert "isNumber '+.0'"
    assert "isNumber '-.0'"
    assert "isNumber '+42.250'"
#   assert "isNumber '+42.250E4'"
#   assert "isNumber '+42.250+E4'"
#   assert "isNumber '-2.250-E4'"
#   assert "isNumber '250E4'"
#   assert "isNumber '250e4'"

    # bad numerics
    assert_fails "isNumber "
    assert_fails "isNumber '+'"
    assert_fails "isNumber '-'"
    assert_fails "isNumber '.'"
    assert_fails "isNumber 'dinosaur'"
    assert_fails "isNumber '+d'"
#   assert_fails "isNumber '123a45'"
#   assert_fails "isNumber '123-45'"
#   assert_fails "isNumber '123+45'"
#   assert_fails "isNumber '123.45'"
    assert_fails "isNumber '#%@' "
    assert_fails "isNumber 'I am Spartacus' "
}

test_isLower()
{
    assert "isLower 'iamspartacus'"
    assert_fails "isLower 'i am spartacus'"
    assert_fails "isLower 'I am Spartacus'"
    assert_fails "isLower '12345'"
    assert_fails "isLower '0'"
    assert_fails "isLower '#%@'"
    assert_fails "isLower"
}

test_isPrint()
{
    assert "isPrint '12345'"
    assert "isPrint '0'"
    assert "isPrint '-12345'"
    assert "isPrint '+12345'"
    assert "isPrint '#%@'"
    assert "isPrint 'I am Spartacus'"
    assert_fails "isPrint"
    local x=$'\e\a\t\r\n'
    assert_fails 'isPrint "$x"'
}

test_isPunct()
{
    assert "isPunct '!,.;:'"
    assert_fails "isPunct '12345'"
    assert_fails "isPunct '0'"
    assert_fails "isPunct '-12345'"
    assert_fails "isPunct '+12345'"
    assert_fails "isPunct"
    assert_fails "isPunct '\t   '"
    assert_fails "isPunct 'I am Spartacus'"
}

test_isSpace()
{
    local x=$'\r\t\n   '
    assert 'isSpace "$x"'
    assert_fails "isSpace '12345'"
    assert_fails "isSpace '0'"
    assert_fails "isSpace '-12345'"
    assert_fails "isSpace '+12345'"
    assert_fails "isSpace"
    assert_fails "isSpace 'I am Spartacus'"
}

test_isUpper()
{
    assert "isUpper 'IAMSPARTACUS'"
    assert_fails "isUpper 'I AM SPARTACUS'"
    assert_fails "isUpper 'I am Spartacus'"
    assert_fails "isUpper '12345'"
    assert_fails "isUpper '0'"
    assert_fails "isUpper '#%@'"
    assert_fails "isUpper"
}
#
# Commented out until isWord is debugged.
#
# test_isWord()
# {
#     assert "isWord 'hello'"
#     assert "isWord 'a1_b2345'"
#     assert "isWord 'R2_D2' "
#     assert "isWord '0' "
#     assert_fails "isWord 'I AM SPARTACUS' "
#     assert_fails "isWord 'I am Spartacus' "
#     assert_fails "isWord '#%@' "
#     assert_fails "isWord "
#     assert_fails "isWord 'I-am-Spartacus' "
# }

test_isXdigit()
{
    assert "isXdigit '0123456789abcdefABCDEF'"
    assert "isXdigit '0' "
    assert_fails "isXdigit 'I AM SPARTACUS'"
    assert_fails "isXdigit 'I am Spartacus'"
    assert_fails "isXdigit '#%@'"
    assert_fails "isXdigit"
}

test_startsWith()
{
    assert "startsWith 'rolling thunder' 'rolling'"
    assert_fails "startsWith 'rolling thunder' 'thunder'"
    assert_fails "startsWith 'rolling thunder' ''"
    assert_fails "startsWith '' 'thunder'"
    assert_fails "startsWith '' ''"
    assert_fails "startsWith"
}

test_endsWith()
{
    assert "endsWith 'rolling thunder' 'thunder'"
    assert_fails "endsWith 'rolling thunder' 'rolling'"
    assert_fails "endsWith 'rolling thunder' ''"
    assert_fails "endsWith '' 'thunder'"
    assert_fails "endsWith '' ''"
    assert_fails "endsWith"
}

test_toLower()
{
    assert_equals "rolling thunder" "$(toLower 'ROLLING Thunder')"
    assert_equals "rolling thunder" "$(toLower 'rolling thunder')"
    assert_equals "" "$(toLower '')"
}

test_toUpper()
{
    assert_equals "ROLLING THUNDER" "$(toUpper 'rolling thunder')"
    assert_equals "ROLLING THUNDER" "$(toUpper 'ROLLING THUNDER')"
    assert_equals "" "$(toUpper '')"
}

test_capitalize()
{
    assert_equals "Rolling Thunder" "$(capitalize 'rolling Thunder')"
    assert_equals "Rolling thunder" "$(capitalize 'Rolling thunder')"
    assert_equals "" "$(capitalize '')"
}

test_trimLeft()
{
    assert_equals " Rolling Thunder" "$(trimLeft 'aabbcc Rolling Thunder' 'aabbcc')"
    assert_equals "Rolling Thunder"  "$(trimLeft '      Rolling Thunder')"
    assert_equals "Rolling Thunder"  "$(trimLeft 'Rolling Thunder' 'no-match')"
}

test_trimRight()
{
    assert_equals "Rolling Thunder " "$(trimRight 'Rolling Thunder aabbcc' 'aabbcc')"
    assert_equals "Rolling Thunder"  "$(trimRight 'Rolling Thunder      ')"
    assert_equals "Rolling thunder"  "$(trimRight 'Rolling thunder' 'no-match')"
}

test_trimWhitespace()
{
    assert_equals "Rolling Thunder" "$(trimWhitespace '         Rolling Thunder         ')"
    assert_equals "Rolling Thunder" "$(trimWhitespace '         Rolling Thunder')"
    assert_equals "Rolling Thunder" "$(trimWhitespace 'Rolling Thunder          ')"
    assert_equals "Rolling Thunder" "$(trimWhitespace 'Rolling Thunder')"
}

# -----------------------------------------------------------

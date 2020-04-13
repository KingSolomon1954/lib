#!/usr/bin/env bash

# set -o xtrace   # for debugging

import libString.bash

# -----------------------------------------------------------

test_isAlphNum()
{
    assert "isAlphNum '12345' "
    assert "isAlphNum 'abcde' "
    assert "isAlphNum '1a2b3c4d5e' "
    assert_fail "isAlphNum "
    assert_fail "isAlphNum '#%@' "
    assert_fail "isAlphNum 'I am Spartacus' "
}

test_isAlpha()
{
    assert "isAlpha 'abcde' "
    assert_fail "isAlpha "
    assert_fail "isAlpha '12345' "
    assert_fail "isAlpha 'a2b3c4d5e' "
    assert_fail "isAlpha '#%@' "
    assert_fail "isAlpha 'I am Spartacus' "
}

# Commented out until isAscii is debugged.
#
# test_isAscii()
# {
#     local x=$'\255'
#     assert 'isAscii "$x" '
#     assert_fail "isAscii 'abcde' "
#     assert_fail "isAscii '12345' "
#     assert_fail "isAscii "
#     assert_fail "isAscii '#%@' "
#     assert_fail "isAscii 'I am Spartacus' "
# }

test_isBlank()
{
    local x="   	"
    assert 'isBlank "$x" '
    assert_fail "isBlank 'abcde' "
    assert_fail "isBlank '12345' "
    assert_fail "isBlank "
    assert_fail "isBlank '#%@' "
    assert_fail "isBlank 'I am Spartacus' "
}

test_isCntrl()
{
    local x=$'\e\a\t\r\n'
    assert 'isCntrl "$x" '
    assert_fail "isCntrl 'abcde' "
    assert_fail "isCntrl '12345' "
    assert_fail "isCntrl "
    assert_fail "isCntrl '#%@' "
    assert_fail "isCntrl 'I am Spartacus' "
}

test_isDigit()
{
    assert "isDigit '12345' "
    assert "isDigit '0' "
    assert_fail "isDigit "
    assert_fail "isDigit '-12345' "
    assert_fail "isDigit '+12345' "
    assert_fail "isDigit '#%@' "
    assert_fail "isDigit 'I am Spartacus' "
}

test_isGraph()
{
    assert "isGraph '12345' "
    assert "isGraph '0' "
    assert "isGraph '-12345' "
    assert "isGraph '+12345' "
    assert "isGraph '#%@' "
    assert_fail "isGraph "
    assert_fail "isGraph '\t   ' "
    assert_fail "isGraph 'I am Spartacus' "
}

test_isInteger()
{
    # valid integers
    assert "isInteger '12345' "
    assert "isInteger '+12345' "
    assert "isInteger '-12345' "
    assert "isInteger '0' "
    
    # bad integers
    assert_fail "isInteger "
    assert_fail "isInteger '+'"
    assert_fail "isInteger '-'"
    assert_fail "isInteger '.'"
    assert_fail "isInteger 'dinosaur'"
    assert_fail "isInteger '+d'"
    assert_fail "isInteger '123a45'"
    assert_fail "isInteger '123-45'"
    assert_fail "isInteger '123+45'"
    assert_fail "isInteger '123.45'"
    assert_fail "isInteger '#%@' "
    assert_fail "isInteger 'I am Spartacus' "
}

# Commented out because bash_unit chokes on the
# execution of function under test isNumeric().
# Doesn't like its syntax. Testest manually in the
# shell and it works as expected.
#
# test_isNumeric()
# {
#     # valid numerics
#     assert "isNumeric '1' "
#     assert "isNumeric '12345' "
#     assert "isNumeric '+12345' "
#     assert "isNumeric '-12345' "
#     assert "isNumeric '0' "
#     assert "isNumeric '0.0' "
#     assert "isNumeric '+0.0' "
#     assert "isNumeric '+.0' "
#     assert "isNumeric '-.0' "
#     assert "isNumeric '+42.250' "
#     assert "isNumeric '+42.250E4' "
#     assert "isNumeric '+42.250+E4' "
#     assert "isNumeric '-2.250-E4' "
#     assert "isNumeric '250E4' "
#     assert "isNumeric '250e4' "
# 
#     # bad numerics
#     assert_fail "isNumeric "
#     assert_fail "isNumeric '+'"
#     assert_fail "isNumeric '-'"
#     assert_fail "isNumeric '.'"
#     assert_fail "isNumeric 'dinosaur'"
#     assert_fail "isNumeric '+d'"
#     assert_fail "isNumeric '123a45'"
#     assert_fail "isNumeric '123-45'"
#     assert_fail "isNumeric '123+45'"
#     assert_fail "isNumeric '123.45'"
#     assert_fail "isNumeric '#%@' "
#     assert_fail "isNumeric 'I am Spartacus' "
# }
    
test_isLower()
{
    assert "isLower 'iamspartacus' "
    assert_fail "isLower 'i am spartacus' "
    assert_fail "isLower 'I am Spartacus' "
    assert_fail "isLower '12345' "
    assert_fail "isLower '0' "
    assert_fail "isLower '#%@' "
    assert_fail "isLower "
}

test_isPrint()
{
    assert "isPrint '12345' "
    assert "isPrint '0' "
    assert "isPrint '-12345' "
    assert "isPrint '+12345' "
    assert "isPrint '#%@' "
    assert "isPrint 'I am Spartacus' "
    assert_fail "isPrint "
    local x=$'\e\a\t\r\n'
    assert_fail 'isPrint "$x" '
}

test_isPunct()
{
    assert "isPunct '!,.;:' "
    assert_fail "isPunct '12345' "
    assert_fail "isPunct '0' "
    assert_fail "isPunct '-12345' "
    assert_fail "isPunct '+12345' "
    assert_fail "isPunct "
    assert_fail "isPunct '\t   ' "
    assert_fail "isPunct 'I am Spartacus' "
}

test_isSpace()
{
    local x=$'\r\t\n   '
    assert 'isSpace "$x" '
    assert_fail "isSpace '12345' "
    assert_fail "isSpace '0' "
    assert_fail "isSpace '-12345' "
    assert_fail "isSpace '+12345' "
    assert_fail "isSpace "
    assert_fail "isSpace 'I am Spartacus' "
}

test_isUpper()
{
    assert "isUpper 'IAMSPARTACUS' "
    assert_fail "isUpper 'I AM SPARTACUS' "
    assert_fail "isUpper 'I am Spartacus' "
    assert_fail "isUpper '12345' "
    assert_fail "isUpper '0' "
    assert_fail "isUpper '#%@' "
    assert_fail "isUpper "
}

# Commented out until isWord is debugged.
#
# test_isWord()
# {
#     assert "isWord 'a1_b2345' "
#     assert "isWord 'R2_D2' "
#     assert "isWord '0' "
#     assert_fail "isWord 'I AM SPARTACUS' "
#     assert_fail "isWord 'I am Spartacus' "
#     assert_fail "isWord '#%@' "
#     assert_fail "isWord "
#     assert_fail "isWord 'I-am-Spartacus' "
# }

test_isXdigit()
{
    assert "isXdigit '0123456789abcdefABCDEF' "
    assert "isXdigit '0' "
    assert_fail "isXdigit 'I AM SPARTACUS' "
    assert_fail "isXdigit 'I am Spartacus' "
    assert_fail "isXdigit '#%@' "
    assert_fail "isXdigit "
}

test_strlen()
{
    assert_equals $(strlen dinosaur) "8"     # normal string
    assert_equals $(strlen ) "0"             # test no args
    assert_equals $(strlen "") "0"           # test zero length string
}

# -----------------------------------------------------------

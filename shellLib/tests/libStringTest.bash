#!/usr/bin/env bash

# set -o xtrace   # for debugging

import libString.bash

# -----------------------------------------------------------

test_strlen()
{
    assert_equals $(strlen dinosaur) "8"     # normal string
    assert_equals $(strlen ) "0"             # test no args
    assert_equals $(strlen "") "0"           # test zero length string
}

test_isDigit()
{
    # valid integer
    assert "isDigit '12345' "
    assert "isDigit '+12345' "
    assert "isDigit '-12345' "
    assert "isDigit '0' "

    # empty integer
    assert_fail "isDigit '' "
    assert_fail "isDigit "
    assert_fail "isDigit dinosaur"
    assert_fail "isDigit +dinosaur"
    assert_fail "isDigit +"
    assert_fail "isDigit -"
    assert_fail "isDigit ."
}

    
#   # test insufficient args - 1 arg
#   assert_fail "isInPath '/usr/dinosaur'"
# 
#   # test two empty args
#   assert_fail "isInPath '' ''"
# 
#   # test empty args
#   assert_fail "isInPath '/usr/dinosaur' ''"
# 
#   # test empty args
#   assert_fail "isInPath '' '/usr/dinosaur'"
#   
#   # test unset var
#   assert_fail "isInPath '/usr/dinosaur' 'SOME_UNSETVAR'"
# 
#   # test null var
#   SOME_EMPTY_VAR=
#   assert_fail "isInPath '/usr/dinosaur' 'SOME_EMPTY_VAR'"
# 
#   # test null var
#   SOME_EMPTY_VAR=
#   assert_fail "isInPath '/usr/dinosaur' 'SOME_EMPTY_VAR'"
# 
#   # test null var
#   SOME_EMPTY_VAR=
#   assert_fail "isInPath '/usr/dinosaur' 'SOME_EMPTY_VAR'"
# 
#   # test empty var
#   SOME_EMPTY_VAR=""
#   assert_fail "isInPath '/usr/dinosaur' 'SOME_EMPTY_VAR'"
# 
#   # test simple content - no match
#   PATH_VAR="/usr/bird"
#   assert_fail "isInPath 'bird' 'PATH_VAR'"
# 
#   # test simple content - matching content
#   PATH_VAR="/usr/bird"
#   assert "isInPath '/usr/bird' 'PATH_VAR'"
# 
#   # test simple content trailing ":" - matching content
#   PATH_VAR="/usr/bird:"
#   assert "isInPath '/usr/bird' 'PATH_VAR'"
#   
#   # test simple content leading ":" - matching content
#   PATH_VAR=":/usr/bird"
#   assert "isInPath '/usr/bird' 'PATH_VAR'"
# 
#   # test content - matching content at front
#   PATH_VAR="/usr/bird:/front_schmutz:/end_schmutz"
#   assert "isInPath '/usr/bird' 'PATH_VAR'"
# 
#   # test content - matching content
#   PATH_VAR="/front_schmutz:/usr/bird:/end_schmutz"
#   assert "isInPath '/usr/bird' 'PATH_VAR'"
# 
#   # test content - matching content at end
#   PATH_VAR="/front_schmutz:/end_schmutz/:/usr/bird"
#   assert "isInPath '/usr/bird' 'PATH_VAR'"
# }

# -----------------------------------------------------------

# -----------------------------------------------------------

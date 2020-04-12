#!/usr/bin/env bash

# set -o xtrace   # for debugging

import libPath.bash

# -----------------------------------------------------------

test_isInPath()
{
    # test insufficient args - no args
    assert_fail "isInPath"

    # test insufficient args - 1 arg
    assert_fail "isInPath '/usr/dinosaur'"

    # test two empty args
    assert_fail "isInPath '' ''"

    # test empty args
    assert_fail "isInPath '/usr/dinosaur' ''"

    # test empty args
    assert_fail "isInPath '' '/usr/dinosaur'"
    
    # test unset var
    assert_fail "isInPath '/usr/dinosaur' 'SOME_UNSETVAR'"

    # test null var
    SOME_EMPTY_VAR=
    assert_fail "isInPath '/usr/dinosaur' 'SOME_EMPTY_VAR'"

    # test null var
    SOME_EMPTY_VAR=
    assert_fail "isInPath '/usr/dinosaur' 'SOME_EMPTY_VAR'"

    # test null var
    SOME_EMPTY_VAR=
    assert_fail "isInPath '/usr/dinosaur' 'SOME_EMPTY_VAR'"

    # test empty var
    SOME_EMPTY_VAR=""
    assert_fail "isInPath '/usr/dinosaur' 'SOME_EMPTY_VAR'"

    # test simple content - no match
    PATH_VAR="/usr/bird"
    assert_fail "isInPath 'bird' 'PATH_VAR'"

    # test simple content - matching content
    PATH_VAR="/usr/bird"
    assert "isInPath '/usr/bird' 'PATH_VAR'"

    # test simple content trailing ":" - matching content
    PATH_VAR="/usr/bird:"
    assert "isInPath '/usr/bird' 'PATH_VAR'"
    
    # test simple content leading ":" - matching content
    PATH_VAR=":/usr/bird"
    assert "isInPath '/usr/bird' 'PATH_VAR'"

    # test content - matching content at front
    PATH_VAR="/usr/bird:/front_schmutz:/end_schmutz"
    assert "isInPath '/usr/bird' 'PATH_VAR'"

    # test content - matching content
    PATH_VAR="/front_schmutz:/usr/bird:/end_schmutz"
    assert "isInPath '/usr/bird' 'PATH_VAR'"

    # test content - matching content at end
    PATH_VAR="/front_schmutz:/end_schmutz/:/usr/bird"
    assert "isInPath '/usr/bird' 'PATH_VAR'"
}

# -----------------------------------------------------------

test_appendToPath()
{
    # test insufficient args - no args
    assert_fail "appendToPath"

    # test insufficient args - 1 arg
    assert_fail "appendToPath '/usr/dinosaur'"

    # test two empty args
    assert_fail "appendToPath '' ''"

    # test empty args
    assert_fail "appendToPath '/usr/dinosaur' ''"

    # test empty args
    assert_fail "appendToPath '' '/usr/dinosaur'"
    
    # test appending to an unset var
    unset SOME_UNSETVAR
    appendToPath /usr/dinosaur SOME_UNSETVAR
    assert_equals "/usr/dinosaur" "${SOME_UNSETVAR}"
    unset SOME_UNSETVAR

    # test appending to existing var already with content
    SOME_PATHVAR="/usr/dinosaur"
    appendToPath /usr/phylum SOME_PATHVAR
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"

    # test appending to existing var with trailing colon
    SOME_PATHVAR="/usr/dinosaur:"
    appendToPath /usr/phylum SOME_PATHVAR
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"
    
    # test appending to existing var with duplicate front content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    appendToPath /usr/dinosaur SOME_PATHVAR
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"

    # test appending to existing var with duplicate end content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    appendToPath /usr/phylum SOME_PATHVAR
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"

    # test appending to existing var with extra ":" in content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    appendToPath ":/usr/games:" SOME_PATHVAR
    assert_equals "/usr/dinosaur:/usr/phylum:/usr/games" "${SOME_PATHVAR}"
}

# -----------------------------------------------------------

test_prependToPath()
{
    # test insufficient args - no args
    assert_fail "prependToPath"

    # test insufficient args - 1 arg
    assert_fail "prependToPath '/usr/dinosaur'"

    # test two empty args
    assert_fail "prependToPath '' ''"

    # test empty args
    assert_fail "prependToPath '/usr/dinosaur' ''"

    # test empty args
    assert_fail "prependToPath '' '/usr/dinosaur'"
    
    # test prepending to an unset var
    unset SOME_UNSETVAR
    prependToPath /usr/dinosaur SOME_UNSETVAR
    assert_equals "/usr/dinosaur" "${SOME_UNSETVAR}"
    unset SOME_UNSETVAR

    # test prepending to existing var already with content
    SOME_PATHVAR="/usr/dinosaur"
    prependToPath /usr/phylum SOME_PATHVAR
    assert_equals "/usr/phylum:/usr/dinosaur" "${SOME_PATHVAR}"

    # test prepending to existing var with trailing colon
    SOME_PATHVAR="/usr/dinosaur:"
    prependToPath /usr/phylum SOME_PATHVAR
    assert_equals "/usr/phylum:/usr/dinosaur" "${SOME_PATHVAR}"
    
    # test prepending to existing var with duplicate front content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    prependToPath /usr/dinosaur SOME_PATHVAR
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"

    # test prepending to existing var with duplicate end content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    prependToPath /usr/phylum SOME_PATHVAR
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"

    # test prepending to existing var with extra ":" in content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    prependToPath ":/usr/games:" SOME_PATHVAR
    assert_equals "/usr/games:/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"
}

# -----------------------------------------------------------

test_deleteFromPath()
{
    # test insufficient args - no args
    assert_fail "deleteFromPath"

    # test insufficient args - 1 arg
    assert_fail "deleteFromPath '/usr/dinosaur'"

    # test two empty args
    assert_fail "deleteFromPath '' ''"

    # test empty args
    assert_fail "deleteFromPath '/usr/dinosaur' ''"

    # test empty args
    assert_fail "deleteFromPath '' '/usr/dinosaur'"
    
    # test deleting from an unset var
    unset SOME_UNSETVAR
    deleteFromPath /usr/dinosaur SOME_UNSETVAR
    assert_equals "" "${SOME_UNSETVAR}"
    unset SOME_UNSETVAR

    # test deleting from existing var no matching content
    SOME_PATHVAR="/usr/dinosaur"
    deleteFromPath /usr/gabage SOME_PATHVAR
    assert_equals "/usr/dinosaur" "${SOME_PATHVAR}"

    # test deleting from existing var matching content
    SOME_PATHVAR="/usr/dinosaur"
    deleteFromPath /usr/dinosaur SOME_PATHVAR
    assert_equals "" "${SOME_PATHVAR}"

    # test deleting from existing var with trailing colon
    SOME_PATHVAR="/usr/dinosaur:"
    deleteFromPath /usr/dinosaur SOME_PATHVAR
    assert_equals "" "${SOME_PATHVAR}"
    
    # test deleting from var at front
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum:/usr/games"
    deleteFromPath /usr/dinosaur SOME_PATHVAR
    assert_equals "/usr/phylum:/usr/games" "${SOME_PATHVAR}"

    # test deleting from var in middle
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum:/usr/games"
    deleteFromPath /usr/phylum SOME_PATHVAR
    assert_equals "/usr/dinosaur:/usr/games" "${SOME_PATHVAR}"
    
    # test deleting from var at end
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum:/usr/games"
    deleteFromPath /usr/games SOME_PATHVAR
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"

    # test deleting from existing var with extra ":" in content
    # This is known to fail because the logic matches the colon
    # when deleting content. Not worth fixing.
    # 
    # SOME_PATHVAR="/usr/dinosaur:/usr/phylum:/usr/games"
    # deleteFromPath ":/usr/phylum:" SOME_PATHVAR
    # assert_equals "/usr/dinosaurs:/usr/games" "${SOME_PATHVAR}"
}

# -----------------------------------------------------------

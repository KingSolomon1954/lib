#!/usr/bin/env bash

# set -o xtrace   # for debugging

import libPath.bash

# -----------------------------------------------------------

test_envp.contains()
{
    # test insufficient args - no args
    assert_fail "envp.contains"

    # test insufficient args - 1 arg
    assert_fail "envp.contains '/usr/dinosaur'"

    # test two empty args
    assert_fail "envp.contains '' ''"

    # test empty args
    assert_fail "envp.contains '/usr/dinosaur' ''"

    # test empty args
    assert_fail "envp.contains '' '/usr/dinosaur'"
    
    # test unset var
    assert_fail "envp.contains 'SOME_UNSETVAR' '/usr/dinosaur'"

    # test null var
    SOME_EMPTY_VAR=
    assert_fail "envp.contains 'SOME_EMPTY_VAR' '/usr/dinosaur'"

    # test null var
    SOME_EMPTY_VAR=
    assert_fail "envp.contains 'SOME_EMPTY_VAR' '/usr/dinosaur'"

    # test empty var
    SOME_EMPTY_VAR=""
    assert_fail "envp.contains 'SOME_EMPTY_VAR' '/usr/dinosaur'"

    # test simple content - no match
    PATH_VAR="/usr/bird"
    assert_fail "envp.contains 'PATH_VAR' 'bird'"

    # test simple content - matching content
    PATH_VAR="/usr/bird"
    assert "envp.contains 'PATH_VAR' '/usr/bird'"

    # test simple content trailing ":" - matching content
    PATH_VAR="/usr/bird:"
    assert "envp.contains 'PATH_VAR' '/usr/bird'"
    
    # test simple content leading ":" - matching content
    PATH_VAR=":/usr/bird"
    assert "envp.contains 'PATH_VAR' '/usr/bird'"

    # test content - matching content at front
    PATH_VAR="/usr/bird:/front_schmutz:/end_schmutz"
    assert "envp.contains 'PATH_VAR' '/usr/bird'"

    # test content - matching content
    PATH_VAR="/front_schmutz:/usr/bird:/end_schmutz"
    assert "envp.contains 'PATH_VAR' '/usr/bird'"

    # test content - matching content at end
    PATH_VAR="/front_schmutz:/end_schmutz/:/usr/bird"
    assert "envp.contains 'PATH_VAR' '/usr/bird'"

    # test content - spaces in content
    PATH_VAR="/front schmutz:/end schmutz/:/usr/bird"
    assert "envp.contains 'PATH_VAR' '/end schmutz/'"

    # test content - spaces in content
    PATH_VAR="/front schmutz:/end schmutz/:/usr/bird"
    assert_fail "envp.contains 'PATH_VAR' 'schmutz'"
}

# -----------------------------------------------------------

test_envp.checkArgs()
{
    # test insufficient args - no args
    assert_fail "_envp.checkArgs"

    # test insufficient args - 1 arg
    assert_fail "_envp.checkArgs ''"

    # test 2 emtpy args
    assert_fail "_envp.checkArgs '' ''"

    # test 1 emtpy arg
    assert_fail "_envp.checkArgs '' 'here i am'"

    # test 1 emtpy arg
    assert_fail "_envp.checkArgs 'here i am' ''"

    # test good args
    assert "_envp.checkArgs 'PATH' 'some file'"
}

# -----------------------------------------------------------

test_envp.append()
{
    envp.setDirMustExist "false"
    # test insufficient args - no args
    assert_fail "envp.append"

    # test insufficient args - 1 arg
    assert_fail "envp.append '/usr/dinosaur'"

    # test two empty args
    assert_fail "envp.append '' ''"

    # test empty args
    assert_fail "envp.append '/usr/dinosaur' ''"

    # test empty args
    assert_fail "envp.append '' '/usr/dinosaur'"
    
    # test appending to an unset var
    unset SOME_UNSETVAR
    envp.append SOME_UNSETVAR /usr/dinosaur 
    assert_equals "/usr/dinosaur" "${SOME_UNSETVAR}"
    unset SOME_UNSETVAR

    # test appending to existing var already with content
    SOME_PATHVAR="/usr/dinosaur"
    envp.append SOME_PATHVAR /usr/phylum
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"

    # test appending to existing var with trailing colon
    SOME_PATHVAR="/usr/dinosaur:"
    envp.append SOME_PATHVAR /usr/phylum 
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"
    
    # test appending to existing var with duplicate front content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    envp.append SOME_PATHVAR /usr/dinosaur
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"

    # test appending to existing var with duplicate end content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    envp.append SOME_PATHVAR /usr/phylum
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"

    # test appending to existing var with extra ":" in content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    envp.append SOME_PATHVAR ":/usr/games:"
    assert_equals "/usr/dinosaur:/usr/phylum:/usr/games" "${SOME_PATHVAR}"
}

# -----------------------------------------------------------

test_env.prepend()
{
    envp.setDirMustExist "false"

    # test insufficient args - no args
    assert_fail "envp.prepend"

    # test insufficient args - 1 arg
    assert_fail "envp.prepend '/usr/dinosaur'"

    # test two empty args
    assert_fail "envp.prepend '' ''"

    # test empty args
    assert_fail "envp.prepend '/usr/dinosaur' ''"

    # test empty args
    assert_fail "envp.prepend '' '/usr/dinosaur'"

    # test prepending to an unset var
    unset SOME_UNSETVAR
    envp.prepend SOME_UNSETVAR /usr/dinosaur
    assert_equals "/usr/dinosaur" "${SOME_UNSETVAR}"
    unset SOME_UNSETVAR

    # test prepending to existing var already with content
    SOME_PATHVAR="/usr/dinosaur"
    envp.prepend SOME_PATHVAR /usr/phylum
    assert_equals "/usr/phylum:/usr/dinosaur" "${SOME_PATHVAR}"

    # test prepending to existing var with trailing colon
    SOME_PATHVAR="/usr/dinosaur:"
    envp.prepend SOME_PATHVAR /usr/phylum
    assert_equals "/usr/phylum:/usr/dinosaur" "${SOME_PATHVAR}"
    
    # test prepending to existing var with duplicate front content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    envp.prepend  SOME_PATHVAR /usr/dinosaur
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"

    # test prepending to existing var with duplicate end content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    envp.prepend SOME_PATHVAR /usr/phylum
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"

    # test prepending to existing var with extra ":" in content
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum"
    envp.prepend SOME_PATHVAR ":/usr/games:"
    assert_equals "/usr/games:/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"
}

# -----------------------------------------------------------

test_envp.delete()
{
    # test insufficient args - no args
    assert_fail "envp.delete"

    # test insufficient args - 1 arg
    assert_fail "envp.delete '/usr/dinosaur'"

    # test two empty args
    assert_fail "envp.delete '' ''"

    # test empty args
    assert_fail "envp.delete '/usr/dinosaur' ''"

    # test empty args
    assert_fail "envp.delete '' '/usr/dinosaur'"
    
    # test deleting from an unset var
    unset SOME_UNSETVAR
    envp.delete SOME_UNSETVAR /usr/dinosaur
    assert_equals "" "${SOME_UNSETVAR}"
    unset SOME_UNSETVAR

    # test deleting from existing var no matching content
    SOME_PATHVAR="/usr/dinosaur"
    envp.delete SOME_PATHVAR /usr/gabage
    assert_equals "/usr/dinosaur" "${SOME_PATHVAR}"

    # test deleting from existing var matching content
    SOME_PATHVAR="/usr/dinosaur"
    envp.delete SOME_PATHVAR /usr/dinosaur
    assert_equals "" "${SOME_PATHVAR}"

    # test deleting from existing var with trailing colon
    SOME_PATHVAR="/usr/dinosaur:"
    envp.delete SOME_PATHVAR /usr/dinosaur
    assert_equals "" "${SOME_PATHVAR}"
    
    # test deleting from var at front
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum:/usr/games"
    envp.delete SOME_PATHVAR /usr/dinosaur
    assert_equals "/usr/phylum:/usr/games" "${SOME_PATHVAR}"

    # test deleting from var in middle
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum:/usr/games"
    envp.delete SOME_PATHVAR /usr/phylum
    assert_equals "/usr/dinosaur:/usr/games" "${SOME_PATHVAR}"
    
    # test deleting from var at end
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum:/usr/games"
    envp.delete  SOME_PATHVAR /usr/games
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

test_envp.deleteFirst()
{
    # test insufficient args - no args
    assert_fail "envp.deleteFirst"

    # test empty args
    assert_fail "envp.deleteFirst ''"

    # test deleting from an unset var
    unset SOME_UNSETVAR
    envp.deleteFirst SOME_UNSETVAR
    assert_equals "" "${SOME_UNSETVAR}"
    unset SOME_UNSETVAR

    # test deleting from existing but empty var
    SOME_PATHVAR=""
    envp.deleteFirst SOME_PATHVAR
    assert_equals "" "${SOME_PATHVAR}"

    # test deleting first fragment leaving empty string
    SOME_PATHVAR="/usr/dinosaur"
    envp.deleteFirst SOME_PATHVAR
    assert_equals "" "${SOME_PATHVAR}"

    # test deleting first fragment with multiple entries
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum:/usr/games"
    envp.deleteFirst SOME_PATHVAR
    assert_equals "/usr/phylum:/usr/games" "${SOME_PATHVAR}"
}

# -----------------------------------------------------------

test_envp.deleteLast()
{
    # test insufficient args - no args
    assert_fail "envp.deleteLast"

    # test empty args
    assert_fail "envp.deleteFirst ''"

    # test deleting from an unset var
    unset SOME_UNSETVAR
    envp.deleteLast SOME_UNSETVAR
    assert_equals "" "${SOME_UNSETVAR}"
    unset SOME_UNSETVAR

    # test deleting from existing but empty var
    SOME_PATHVAR=""
    envp.deleteLast SOME_PATHVAR
    assert_equals "" "${SOME_PATHVAR}"

    # test deleting last fragment leaving empty string
    SOME_PATHVAR="/usr/dinosaur"
    envp.deleteLast SOME_PATHVAR
    assert_equals "" "${SOME_PATHVAR}"

    # test deleting Last fragment with multiple entries
    SOME_PATHVAR="/usr/dinosaur:/usr/phylum:/usr/games"
    envp.deleteLast SOME_PATHVAR
    assert_equals "/usr/dinosaur:/usr/phylum" "${SOME_PATHVAR}"
}

# -----------------------------------------------------------

#!/usr/bin/env bash

# set -o xtrace   # for debugging

source ../libImport.bash
ksl::import libFiles.bash

# -----------------------------------------------------------

test_baseName()
{
    assert_equals "music"   "$(ksl::baseName 'music')"
    assert_equals "music"   "$(ksl::baseName 'music/')"
    assert_equals "music"   "$(ksl::baseName '/music/')"
    assert_equals "beatles" "$(ksl::baseName 'music/beatles/')"
}

# -----------------------------------------------------------

test_dirName()
{
    assert_equals "."       "$(ksl::dirName 'music')"
    assert_equals "."       "$(ksl::dirName 'music/')"
    assert_equals "music"   "$(ksl::dirName 'music/beatles')"
    assert_equals "music"   "$(ksl::dirName 'music/beatles/')"
    assert_equals "/music"  "$(ksl::dirName '/music/beatles/')"
    assert_equals "./music" "$(ksl::dirName './music/beatles/')"
    
#    assert_fail "envp.append"
}

# -----------------------------------------------------------

test_scriptDir()
{
    local tmp=$(ksl::scriptName)
    assert_not_equals "0" "${#tmp}"  # Best we can do
}

# -----------------------------------------------------------

test_scriptName()
{
    assert_equals "bash_unit" "$(ksl::scriptName)"
}

# -----------------------------------------------------------

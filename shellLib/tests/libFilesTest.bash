#!/usr/bin/env bash

# set -o xtrace   # for debugging

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
    local arg0="/usr/bin/grep"
    assert_equals "/usr/bin"   "$(ksl::scriptDir ${arg0})"
}

# -----------------------------------------------------------

test_scriptName()
{
    local arg0="/usr/bin/grep"
    assert_equals "grep"   "$(ksl::scriptName ${arg0})"
}

# -----------------------------------------------------------

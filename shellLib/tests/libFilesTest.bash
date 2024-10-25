#!/usr/bin/env bash

# set -o xtrace   # for debugging

ksl::import libFiles.bash

# -----------------------------------------------------------

test_basename()
{
    assert_equals "music"   "$(ksl::baseName 'music')"
    assert_equals "music"   "$(ksl::baseName 'music/')"
    assert_equals "music"   "$(ksl::baseName '/music/')"
    assert_equals "beatles" "$(ksl::baseName 'music/beatles/')"
}

# -----------------------------------------------------------

test_dirname()
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

#!/usr/bin/env bash

isColorCapable()
{
    return 1
}


enableColor()
{
    isColorCapable
}

testIt()
{
    enableColor
    echo "return code is actually $?"

    local -i ret=$(enableColor)
    echo "But this return code is $?, but should be 1"
    echo "And ret is $ret but should be 1"
    if [ $ret -eq 0 ]; then
        echo "ret should be true: $ret"
    else
        echo "ret should be false: $ret"
    fi
}    
    
testIt

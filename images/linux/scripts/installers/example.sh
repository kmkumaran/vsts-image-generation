#!/bin/bash

## This is an example script that can be copied to add a new software installer

## Source any of the helpers you may need using the $HELPER_SCRIPTS environment variable
source $HELPER_SCRIPTS/dcoument.sh

echo "Checking to see if the installer script has already been run"
if [ $EXAMPLE_VAR ]; then
    $EXAMPLE_VAR=1.0.0
else
    echo "Example variable already set to $EXAMPLE_VAR"
fi

echo "Testing to make sure that script performed as expected, and basic scenarios work"
if [ -z $EXAMPLE_VAR ]; then
    echo "EXAPMLE_VAR variable was not set as expected"
    return -1
else

echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Example Var ($EXAMPLE_VAR)"

## CHJOHN: TODO
#!/bin/bash
###############################################################################
# This is a collection of helper functions to be used in the various install  #
# scripts relating to apt-get packages                                        #
###############################################################################

## Use dpkg to figure out if a package has already been installed
## Example use: 
## if ! IsInstalled packageName; then
##     echo "packageName is not insallted!"
## fi
function IsInstalled {
    dpkg -S $1 &> /dev/null
}

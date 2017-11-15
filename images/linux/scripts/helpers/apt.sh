#!/bin/bash
################################################################################
##  File:  apt.sh
##  Team:  CI-Platform
##  Desc:  This script contains helper functions for using dpkg and apt
################################################################################

## Use dpkg to figure out if a package has already been installed
## Example use:
## if ! IsInstalled packageName; then
##     echo "packageName is not insallted!"
## fi
function IsInstalled {
    dpkg -S $1 &> /dev/null
}

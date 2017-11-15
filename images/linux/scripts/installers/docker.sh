#!/bin/bash
################################################################################
##  File:  docker.sh
##  Team:  CI-Platform
##  Desc:  Installs the correct version of docker onto the image, and pulls
##         down the default docker image used for building on ubuntu
################################################################################

source $HELPER_SCRIPTS/apt.sh
source $HELPER_SCRIPTS/document.sh

DOCKER_PACKAGE=docker-ce
DEFAULT_DOCKER_IMAGE=microsoft/vsts-agent:ubuntu-16.04-docker-17.03.0-ce-standard

## Check to see if docker is already installed
echo "Determing if Docker ($DOCKER_PACKAGE) is installed"
if ! IsInstalled $DOCKER_PACKAGE; then
    echo "Docker ($DOCKER_PACKAGE) was not found. Installing..."
    apt-get remove -y docker docker-engine docker.io
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce
else
    echo "Docker ($DOCKER_PACKGE) is already installed"
fi

## Always pull down latest docker image, as it will no-op if it already exists
echo "Pulling down latest Docker image ($DEFAULT_DOCKER_IMAGE)"
docker pull $DEFAULT_DOCKER_IMAGE


## Add version information to the metadata file
echo "Documenting Docker version"
DOCKER_VERSION=`docker -v`ß
DocumentInstalledItem $DOCKER_VERSION

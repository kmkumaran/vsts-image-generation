################################################################################
##  File:  Install-Cmake.ps1
##  Team:  CI-Build
##  Desc:  Install Cmake
################################################################################

Import-Module -Name ImageHelpers -Force

choco install cmake.install --version 3.9.4 -y --installargs 'ADD_CMAKE_TO_PATH=""System""'

$env:Path = Get-MachinePath

if(Get-Command -Name 'cmake')
{
    Write-Host "Cmake $(cmake -version) on path"
    exit 0
}
else
{
    Write-Host 'cmake not on path'
    exit 1
}


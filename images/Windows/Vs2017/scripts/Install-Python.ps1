################################################################################
##  File:  Install-Python.ps1
##  Team:  CI-X
##  Desc:  Configure python on path based on what VS installs
##         Must run after VS is installed
################################################################################

Import-Module -Name ImageHelpers -Force

$pythonDir = Get-Item -Path 'C:\Program Files\Python3*'

if($pythonDir -is [array])
{
    Write-Host "More than one python 3 install found"
    Write-Host $pythonDir
    exit 1
}

$currentPath = Get-MachinePath

if ($currentPath | Select-String -SimpleMatch $pythonDir.FullName)
{
    Write-Host $pythonDir.FullName ' is already in path'
    #exit 0
}

$env:Path = Add-MachinePathItem -PathItem $pythonDir.FullName
setx PYTHON_HOME $pythonDir.FullName /M

Write-Host "Python $(python --version) on path"
exit 0
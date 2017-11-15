################################################################################
##  File:  Install-NodeLts.ps1
##  Team:  CI-X
##  Desc:  Install nodejs-lts and other common node tools.
##         Must run after python is configured
################################################################################

Import-Module -Name ImageHelpers -Force

$PrefixPath = 'C:\npm\prefix'
$CachePath = 'C:\npm\cache'

New-Item -Path $PrefixPath -Force -ItemType Directory
New-Item -Path $CachePath -Force -ItemType Directory

choco install nodejs-lts --version 6.11.5 -y --force

Add-MachinePathItem $PrefixPath
Add-MachinePathItem $CachePath
$env:Path = Get-MachinePath

Write-Host "Node $(node --version) on path"
Write-Host "Npm $(npm -version) on path"

npm config set cache $PrefixPath
npm config set prefix $CachePath

npm install -g gulp-cli
npm install -g grunt-cli
npm install -g bower
npm install -g cordova
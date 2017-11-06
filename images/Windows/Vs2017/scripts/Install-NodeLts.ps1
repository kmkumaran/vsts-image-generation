# Install nodejs npm and common node tools

Import-Module -Name ImageHelpers -Force

choco install nodejs-lts --version 6.11.5 -y --force

New-Item -Path C:\npm\prefix -Force -ItemType Directory
New-Item -Path C:\npm\cache -Force -ItemType Directory

setx NPM_CONFIG_PREFIX=C:\npm\prefix /M
setx NPM_CONFIG_CACHE=C:\npm\cache /M

$env:Path = Get-MachinePath

Write-Host "Node $(node --version) on path"
Write-Host "Npm $(npm -version) on path"

npm install -g glup-cli
npm install -g grunt-cli
npm install -g bower
npm install -g cordova
npm install -g iconic
choco install nodejs-lts --version 6.11.5 -y

refreshenv

Write-Host "Node $(node -version) on path"
Write-Host "Npm $(npm -version) on path"
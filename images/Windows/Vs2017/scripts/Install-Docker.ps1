Set-PSRepository -InstallationPolicy Trusted -Name PSGallery
Write-Host "Install-Module DockerProvider"
Install-Module DockerProvider -Force

Write-Host "Install-Package Docker"
Install-Package Docker -ProviderName DockerProvider -Force
Start-Service docker

choco install docker-compose -y

Write-Host "docker $(docker version) on path"
Write-Host "docker-compose $(docker-compose version) on path"
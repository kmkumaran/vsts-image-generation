Set-PSRepository -InstallationPolicy Trusted -Name PSGallery
Write-Host "Install-Module DockerProvider"
Install-Module DockerProvider -Force

Write-Host "Install-Package Docker"
Install-Package Docker -ProviderName DockerProvider -Force
Start-Service docker

choco install docker-compose -y

if((Get-Command -Name 'docker') -and (Get-Command -Name 'docker-compose'))
{
    Write-Host "docker $(docker version) on path"
    Write-Host "docker-compose $(docker-compose version) on path"
    exit 0
}
else
{
    Write-Host "docker or docker-compose are no on path"
    exit 1
}


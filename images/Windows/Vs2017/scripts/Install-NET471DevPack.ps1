################################################################################
##  File:  Install-NET471DevPack.ps1
##  Team:  CI-Build
##  Desc:  Install .NET 4.7.1 targeting pack.
################################################################################

# at the moment this will not install successfully over the WinRM channel and I am unsure why.
#choco install netfx-4.7.1-devpack -y --force --no-progress

# this seems to work
Invoke-WebRequest https://download.microsoft.com/download/9/0/1/901B684B-659E-4CBD-BEC8-B3F06967C2E7/NDP471-DevPack-ENU.exe -OutFile NDP471-DevPack-ENU.exe
Start-Process NDP471-DevPack-ENU.exe -ArgumentList '/install', '/quiet' -NoNewWindow -Wait
Remove-Item -Force NDP471-DevPack-ENU.exe

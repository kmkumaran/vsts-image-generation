################################################################################
##  File:  Install-NET471.ps1
##  Team:  CI-Build
##  Desc:  Install .NET 4.7.1
##         Can possibly remove when VS installs this
################################################################################

choco install dotnet4.7.1 -y --force --no-progress
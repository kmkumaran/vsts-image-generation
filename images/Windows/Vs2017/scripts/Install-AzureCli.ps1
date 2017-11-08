###############################################################################
#
#   Install Azure CLI
#   owner: RM
#
###############################################################################

Import-Module -Name ImageHelpers -Force

choco install azure-cli --version 2.0.20 -y

$env:Path = Get-MachinePath

if(Get-Command -Name 'az')
{
    Write-Host "Azure Cli $(az --version) on path"
    exit 0
}
else
{
    Write-Error "Azure Cli not on path"
    exit 1
}



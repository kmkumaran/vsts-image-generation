Import-Module -Name ImageHelpers

choco install git --version 2.15.0 -y --package-parameters= "/GitOnlyOnPath /WindowsTerminal /NoShellIntegration"

$env:Path = Get-MachinePath

Write-Host "Git $(git --version) on path"
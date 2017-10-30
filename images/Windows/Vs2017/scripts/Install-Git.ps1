choco install git --version 2.15.0 -y --package-parameters= "/GitOnlyOnPath /WindowsTerminal /NoShellIntegration"

Write-Host "Git $(git --version) on path"
################################################################################
##  File:  Install-WindowsUpdates.ps1
##  Team:  CI-Platform
##  Desc:  Install Windows Updates.
##         Should be run at end just before Antivirus.
################################################################################

Write-Host "Run windows updates"
Install-Module -Name PSWindowsUpdate -Force -AllowClobber
Get-WUInstall -WindowsUpdate -AcceptAll -UpdateType Software -IgnoreReboot
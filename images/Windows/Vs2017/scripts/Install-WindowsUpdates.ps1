###############################################################################
#
#   Install Windows Updates
#   Should be run at end just before Antivirus
#   owner: CI Platform
#
###############################################################################

Write-Host "Run windows updates"
Install-Module -Name PSWindowsUpdate -Force -AllowClobber
Get-WUInstall -WindowsUpdate -AcceptAll -UpdateType Software -IgnoreReboot
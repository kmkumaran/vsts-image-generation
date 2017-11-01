Write-Host "Run windows updates"
Install-Module -Name PSWindowsUpdate -Force -AllowClobber
Get-WUInstall -WindowsUpdate -AcceptAll -UpdateType Software -IgnoreReboot
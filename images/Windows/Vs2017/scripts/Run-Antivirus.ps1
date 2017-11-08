###############################################################################
#
#   Run a full antivirus scan
#   Run right after cleanup before we sysprep
#   owner: CI Platform
#
###############################################################################

Write-Host "Run antivirus"
Push-Location "C:\Program Files\Windows Defender"
# Full Scan
.\MpCmdRun.exe -Scan -ScanType 2
Pop-Location
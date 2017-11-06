Write-Host "Run antivirus"
Push-Location "C:\Program Files\Windows Defender"
# Full Scan
.\MpCmdRun.exe -Scan -ScanType 2
Pop-Location
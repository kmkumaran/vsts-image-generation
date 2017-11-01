Write-Host "Run antivirus"
#Push-Location "C:\Program Files\Windows Defender"
# Full Scan
#.\MpCmdRun.exe -Scan -ScanType 2
#Pop-Location

Write-Host "Cleanup WinSxS"
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

Write-Host "Clean up various directories"
@(
    "C:\\Recovery",
    "$env:windir\\logs",
    "$env:windir\\winsxs\\manifestcache",
    "$env:windir\\Temp",
    "$env:windir\\Installer"
) | ForEach-Object {
    if (Test-Path $_) {
        Write-Host "Removing $_"
        try {
            Takeown /d Y /R /f $_
            Icacls $_ /GRANT:r administrators:F /T /c /q  2>&1 | Out-Null
            Remove-Item $_ -Recurse -Force | Out-Null 
        }
        catch { $global:error.RemoveAt(0) }
    }
}

Write-Host "Setting local execution policy"
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope MachinePolicy  -ErrorAction Continue | Out-Null
Get-ExecutionPolicy -List
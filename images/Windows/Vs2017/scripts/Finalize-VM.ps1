################################################################################
##  File:  Finalize-VM.ps1
##  Team:  CI-Platform
##  Desc:  Clean up folders temp folders after installs to save space
################################################################################

Write-Host "Cleanup WinSxS"
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

$ErrorActionPreference = 'silentlycontinue'

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

$ErrorActionPreference = 'Continue'
$pythonDir = Get-Item -Path 'C:\Program Files\Python3*'

if($pythonDir -is [array])
{
    Write-Host "More than one python 3 install found"
    Write-Host $pythonDir
    exit 1
}

$currentPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path

if ($currentPath | Select-String -SimpleMatch $pythonDir.FullName)
{
    Write-Host $pythonDir.FullName ' is already in path'
    #exit 0
}

$newPath = $pythonDir.FullName + ';' + $currentPath

Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name Path -Value $newPath
$env:Path = $newPath

Write-Host "Python $(python --version) on path"
exit 0
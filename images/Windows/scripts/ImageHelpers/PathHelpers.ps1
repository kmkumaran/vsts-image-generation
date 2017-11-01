function Test-MachinePath{
    [CmdletBinding()]
    param(
        [string]$PathItem
    )

    $currentPath = Get-MachinePath

    $pathItems = $currentPath.Split(';')

    if($pathItems.Contains($PathItem))
    {
        return $true
    }
    else
    {
        return $false
    }
}

function Update-MachinePath{
    [CmdletBinding()]
    param(
        [string]$PathItem
    )

    $currentPath = Get-MachinePath
    $newPath = $PathItem + ';' + $currentPath
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name Path -Value $newPath
    return $newPath
}

function Get-MachinePath{
    [CmdletBinding()]
    param(

    )
    $currentPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
    return $currentPath
}
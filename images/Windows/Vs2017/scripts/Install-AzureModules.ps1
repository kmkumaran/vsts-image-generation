################################################################################
##  File:  Install-AzureModules.ps1
##  Team:  ReleaseManagement
##  Desc:  Install Azure PowerShell modules
################################################################################

Set-PSRepository -InstallationPolicy Trusted -Name PSGallery
# First ensure that only Azure PowerShell version 2.1.0 is installed

# We try to detect the whether Azure PowerShell is installed using .msi file. If it is installed, we find it's version, and if the version is anything other than 2.1.0, then it needs to be uninstalled manually (because the uninstallation requires the PowerShell session to be closed)
$regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
$installedApplications = Get-ItemProperty -Path $regKey
$SdkVersion = ($installedApplications | Where-Object { $_.DisplayName -and $_.DisplayName.toLower().Contains("microsoft azure powershell") } | Select-Object -First 1).DisplayVersion

if($SdkVersion -eq "2.1.0")
{
    Write-Host "An Azure PowerShell installation through .msi file has been detected. This installation will be retained"
}
elseif($SdkVersion -eq $null)
{
    Write-Host "No .msi Installation Present"
}
else
{
    Write-Host "An Azure PowerShell Installation through installer has been detected and it does not have a version 2.1.0. Please close this powershell session and manually uninstall the Azure PowerShell from the Add or Remove Programs in the Control Panel. Then, rerun this script from an Admin PowerShell"
    throw "An Azure PowerShell Installation through installer has been detected and it does not have a version 2.1.0. Please close this powershell session and manually uninstall the Azure PowerShell from the Add or Remove Programs in the Control Panel. Then, rerun this script from an Admin PowerShell"
}

# We will try to uninstall any installation of Azure PowerShell that is not 2.1.0

$modules = Get-Module -Name Azure -ListAvailable
Write-Host "The Azure Modules initially present are:"
$modules | Select-Object Name,Version,Path | Format-Table

foreach($module in $modules)
{
    # add logging for telling what module we are working on now
    if($module.Version.tostring() -eq "2.1.0")
    {
        Write-Host " It is detected that Azure Module version 2.1.0 is already installed."
    }
    else
    {
        if(Test-Path -LiteralPath $module.Path)
        {
            try
            {
                Uninstall-Module -Name Azure -RequiredVersion $module.Version.tostring() -Force
            }
            catch
            {
                Write-Host "The Uninstallation of Azure Module version: $($module.Version.tostring()) failed with the error: $($_.Exception.Message) . Please Check if there isn't any other PowerShell session open."
                throw $_.Exception.Message
            }
        }
    }
}

$modules = Get-Module -Name AzureRM -ListAvailable
Write-Host "The AzureRM Modules initially present are:"
$modules | Select-Object Name,Version,Path | Format-Table

foreach($module in $modules)
{
    # add logging for telling what module we are working on now
    if($module.Version.tostring() -eq "2.1.0")
    {
        Write-Host "It is detected that AzureRM Module version 2.1.0 is already installed through the Install-Module cmdlet."
    }
    else
    {
        if(Test-Path -LiteralPath $module.Path)
        {
            try
            {
                Uninstall-Module -Name AzureRM -RequiredVersion $module.Version.tostring() -Force
            }
            catch
            {
                Write-Host "The Uninstallation of AzureRM Module version: $($module.Version.tostring()) failed with the error: $($_.Exception.Message) . Please Check if there isn't any other PowerShell session open."
                throw $_.Exception.Message
            }
        }
    }
}

#after this, the only installations available through a Get-Module cmdlet should be 2.1.0 or nothing
# Now we will try to install Azure (2.1.0) and AzureRM (2.1.0) modules

$modules = Get-Module -Name Azure -ListAvailable

foreach($module in $modules)
{
    Write-Host "Module found: $($module.Name)  Module Version: $($module.Version)"
    if($module.Version.ToString() -eq "2.1.0")
    {
        $isAzureModule_2_1_0_Present = $true
    }
    else
    {
        Write-Host "Another installation of Azure module is detected with version $($module.Version.ToString()) at path: $($module.Path)"
        throw "Azure module(any version except 2.1.0) uninstallation unsuccessful"
    }
}

$modules = Get-Module -Name AzureRM -ListAvailable

foreach($module in $modules)
{
    write-host "Module found: $($module.Name)  Module Version: $($module.Version)"
    if($module.Version.ToString() -eq "2.1.0")
    {
        $isAzureRmModule_2_1_0_Present = $true
    }
    else
    {
        Write-Host "Another installation of AzureRM module is detected with version $($module.Version.ToString()) at path: $($module.Path)"
        throw "AzureRM module(any version except 2.1.0) uninstallation unsuccessful"
    }
}

if($isAzureModule_2_1_0_Present -eq $true)
{
    Write-Host "Azure module with version 2.1.0 is already installed"
}
else {
    Write-Host "Azure module 2.1.0 is not installed. Beginning installation of Azure module 2.1.0"
    Install-Module -Name Azure -RequiredVersion 2.1.0 -AllowClobber -Force
}

if($isAzureRmModule_2_1_0_Present -eq $true)
{
    Write-Host "AzureRM module with version 2.1.0 is already installed"
}
else {
    write-host "AzureRM module 2.1.0 is not installed. Beginning installation of AzureRM module 2.1.0"
    Install-Module -Name AzureRM -RequiredVersion 2.1.0 -AllowClobber -Force
}


## Now we validate whether the installation process for Azure PowerShell 2.1.0 was successful or not

    $modules = Get-Module -Name Azure -ListAvailable
    if($modules.length -gt 1) {
        Write-Host "There is more than 1 installation of Azure Module on the machine. Checking to see if any of them have a version other than 2.1.0"
    }

    foreach($module in $modules)
    {
        if($module.Version.ToString() -eq "2.1.0")
        {
            Write-Host "Detected Azure Module 2.1.0 in path: $($module.Path)"
        }
        else
        {
            Write-Host "An Azure Module with version $($module.Version.ToString()) is detected in path: $($module.Path)"
            throw "An Azure Module with version $($module.Version.ToString()) is detected. Please check whether uninstallation succeeded."
        }
    }

    $modules = Get-Module -Name AzureRM -ListAvailable
    if($modules.length -gt 1) {
        Write-Host "There is more than 1 installation of AzureRM Module on the machine. Checking to see if any of them have a version other than 2.1.0"
    }

    foreach($module in $modules)
    {
        if($module.Version.ToString() -eq "2.1.0")
        {
            Write-Host "Detected AzureRM Module 2.1.0 in path: $($module.Path)"
        }
        else
        {
            Write-Host "An AzureRM Module with version $($module.Version.ToString()) is detected in path: $($module.Path)"
            throw "An AzureRM Module with version $($module.Version.ToString()) is detected. Please check whether uninstallation succeeded."
        }
    }

# the following listings should show that the azure module 2.1.0 and azurerm module 2.1.0 are the only Azure,AzureRM modules present
Get-Module -ListAvailable -Name Azure | Select-Object Name,Version,Path | Format-Table
Get-Module -ListAvailable -Name AzureRM | Select-Object Name,Version,Path | Format-Table

##################### NOW WE HAVE Installations of Azure and AzureRM Module , both are version 2.1.0, no other installation is present



#### NOW The correct Modules need to be saved in C:\Modules

if($(Test-Path -LiteralPath "C:\Modules") -eq $true)
{
    Write-Host "C:\Modules directory is already present. Beginning to clear it up completely"
    Remove-Item -Path "C:\Modules" -Recurse -Force
}

mkdir "C:\Modules"

$directoryListing = Get-ChildItem -Path "C:\Modules"

if($directoryListing.Length -gt 0)
{
     Write-Host "C:\Modules was not deleted properly. It still has the following contents:"
     $directoryListing
}
else {
    Write-Host "The Directory is clean. There are no contents present in it"
}

#### create directories for saving the azure and azurerm modules. This will be done for Azure 3.8.0, AzureRM 3.8.0, and Azure 4.2.1 and AzureRM 4.2.1

$pathToModule = "C:\Modules\azure_3.8.0"
mkdir $pathToModule
Save-Module -Name Azure -RequiredVersion 3.8.0 -Path $pathToModule -Force



$pathToModule = "C:\Modules\azurerm_3.8.0"
mkdir $pathToModule
Save-Module -Name AzureRM -RequiredVersion 3.8.0 -Path $pathToModule -Force



$pathToModule = "C:\Modules\azure_4.2.1"
mkdir $pathToModule
Save-Module -Name Azure -RequiredVersion 4.2.1 -Path $pathToModule -Force



$pathToModule = "C:\Modules\azurerm_4.2.1"
mkdir $pathToModule
Save-Module -Name AzureRM -RequiredVersion 4.2.1 -Path $pathToModule -Force

$env:PSModulePath = $env:PSModulePath + ";C:\Modules"

### Finally we print all available modules one last time

$modules = Get-Module -Name Azure -ListAvailable
Write-Host "The Azure Modules finally present are:"
$modules | Select-Object Name,Version,Path | Format-Table

$modules = Get-Module -Name AzureRM -ListAvailable
Write-Host "The AzureRM Modules finally present are:"
$modules | Select-Object Name,Version,Path | Format-Table

Write-Host "The contents of the C:\Modules directory are:"
Get-ChildItem -Path "C:\Modules" | Format-Table


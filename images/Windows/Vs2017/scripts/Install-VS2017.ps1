################################################################################
##  File:  Install-VS2017.ps1
##  Team:  CI-Build
##  Desc:  Install Visual Studio 2017
################################################################################

Function InstallVS
{
  Param
  (
    [String]$WorkLoads,
    [String]$Sku,
    [String] $VSBootstrapperURL
  )

  $exitCode = -1

  try
  {
    Write-Host "Downloading Bootstrapper ..."
    Invoke-WebRequest -Uri $VSBootstrapperURL -OutFile "${env:Temp}\vs_$Sku.exe"

    $FilePath = "${env:Temp}\vs_$Sku.exe"
    $Arguments = ('/c', $FilePath, $WorkLoads, '--quiet', '--norestart', '--wait', '--nocache' )

    Write-Host "Starting Install ..."
    $process = Start-Process -FilePath cmd.exe -ArgumentList $Arguments -Wait -PassThru
    $exitCode = $process.ExitCode

    if ($exitCode -eq 0 -or $exitCode -eq 3010)
    {
      Write-Host -Object 'Installation successful'
      return $exitCode
    }
    else
    {
      Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."

      # this wont work because of log size limitation in extension manager
      # Get-Content $customLogFilePath | Write-Host

      exit $exitCode
    }
  }
  catch
  {
    Write-Host -Object "Failed to install Visual Studio. Check the logs for details in $customLogFilePath"
    Write-Host -Object $_.Exception.Message
    exit -1
  }
}

$WorkLoads = '--allWorkloads --includeRecommended ' + `
                '--add Microsoft.Net.Component.4.6.2.SDK ' + `
                '--add Microsoft.Net.Component.4.6.2.TargetingPack ' + `
                '--add Microsoft.Net.Component.4.7.SDK ' + `
                '--add Microsoft.Net.Component.4.7.TargetingPack ' + `
                '--add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools ' + `
                '--add Microsoft.Net.ComponentGroup.4.7.DeveloperTools ' + `
                '--add Microsoft.Net.Core.Component.SDK.1x ' + `
                '--add Microsoft.NetCore.1x.ComponentGroup.Web ' + `
                '--add Microsoft.VisualStudio.Component.Azure.Storage.AzCopy ' + `
                '--add Microsoft.VisualStudio.Component.PowerShell.Tools ' + `
                '--add Microsoft.VisualStudio.Component.VC.140 ' + `
                '--add Component.Dotfuscator ' + `
                '--add Microsoft.Net.Component.4.6.2.SDK ' + `
                '--add Microsoft.Net.Component.4.6.2.TargetingPack ' + `
                '--add Microsoft.Net.Component.4.7.SDK ' + `
                '--add Microsoft.Net.Component.4.7.TargetingPack ' + `
                '--add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools ' + `
                '--add Microsoft.Net.ComponentGroup.4.7.DeveloperTools ' + `
                '--add Microsoft.Net.Core.Component.SDK.1x ' + `
                '--add Microsoft.VisualStudio.Component.VC.140 ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATL ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATLMFC ' + `
                '--add Microsoft.VisualStudio.Component.VC.ClangC2 ' + `
                '--add Microsoft.VisualStudio.Component.VC.CLI.Support ' + `
                '--add Microsoft.VisualStudio.Component.VC.Modules.x86.x64 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.10240 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.10586 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.14393 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.15063.Desktop ' + `
                '--add Component.Unreal ' + `
                '--add Component.Unreal.Android ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.10240 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.10586 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.14393 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.15063.Desktop ' + `
                '--add Component.Android.SDK23 ' + `
                '--add Microsoft.Net.Core.Component.SDK.1x ' + `
                '--add Microsoft.NetCore.1x.ComponentGroup.Web ' + `
                '--add Microsoft.Net.Component.4.6.2.SDK ' + `
                '--add Microsoft.Net.Component.4.6.2.TargetingPack ' + `
                '--add Microsoft.Net.Component.4.7.SDK ' + `
                '--add Microsoft.Net.Component.4.7.TargetingPack ' + `
                '--add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools ' + `
                '--add Microsoft.Net.ComponentGroup.4.7.DeveloperTools ' + `
                '--add Microsoft.Net.Core.Component.SDK.1x ' + `
                '--add Microsoft.NetCore.1x.ComponentGroup.Web ' + `
                '--add Microsoft.VisualStudio.Component.TestTools.WebLoadTest ' + `
                '--add Microsoft.VisualStudio.Web.Mvc4.ComponentGroup ' + `
                '--add Component.CPython2.x64 ' + `
                '--add Microsoft.Component.PythonTools.UWP ' + `
                '--add Microsoft.VisualStudio.Component.VC.140 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.10586 ' + `
                '--add Microsoft.Component.VC.Runtime.OSSupport ' + `
                '--add Microsoft.VisualStudio.Component.VC.Tools.ARM ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.10240 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.10586 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.14393 ' + `
                '--add Microsoft.VisualStudio.ComponentGroup.UWP.VC ' + `
                '--add Component.Dotfuscator ' + `
                '--add Microsoft.Component.VC.Runtime.OSSupport ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATL ' + `
                '--add Microsoft.VisualStudio.Component.VC.ATLMFC ' + `
                '--add Microsoft.VisualStudio.Component.VSSDK ' + `
                '--add Microsoft.VisualStudio.Component.LinqToSql ' + `
                '--add Microsoft.VisualStudio.Component.TestTools.CodedUITest ' + `
                '--add Microsoft.VisualStudio.Component.TestTools.Core ' + `
                '--add Microsoft.VisualStudio.Component.TypeScript.2.0 ' + `
                '--add Microsoft.VisualStudio.Component.TypeScript.2.1 ' + `
                '--add Microsoft.VisualStudio.Component.TypeScript.2.2 ' + `
                '--add Microsoft.VisualStudio.Component.VC.Tools.ARM64 ' + `
                '--add Microsoft.VisualStudio.Component.Windows10SDK.16299.Desktop.arm ' + `
                '--remove Component.Xamarin.Inspector ' + `
                '--remove Component.Xamarin.Profiler ' + `
                '--remove Component.Xamarin.RemotedSimulator ' + `
                '--remove Microsoft.VisualStudio.Component.CodeClone ' + `
                '--remove Microsoft.VisualStudio.Component.CodeMap ' + `
                '--remove Microsoft.VisualStudio.Component.Git ' + `
                '--remove Microsoft.VisualStudio.Component.Graphics.Tools ' + `
                '--remove Microsoft.VisualStudio.Component.Graphics.Win81 ' + `
                '--remove Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd ' + `
                '--remove Microsoft.VisualStudio.Component.VC.DiagnosticTools '

$Sku = 'Enterprise'
$VSBootstrapperURL = 'https://aka.ms/vs/15/release/vs_enterprise.exe'

$ErrorActionPreference = 'Stop'

# Install VS
$exitCode = InstallVS -WorkLoads $WorkLoads -Sku $Sku -VSBootstrapperURL $VSBootstrapperURL

# Find the version of VS installed for this instance
# Only supports a single instance
$vsProgramData = Get-Item -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
$instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

if($instanceFolders -is [array])
{
    Write-Host "More than one instance installed"
    exit 1
}

$catalogContent = Get-Content -Path ($instanceFolders.FullName + '\catalog.json')
$catalog = $catalogContent | ConvertFrom-Json
Write-Host "Visual Studio version" $catalog.info.id "installed"

exit $exitCode
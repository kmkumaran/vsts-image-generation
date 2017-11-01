function DockerPull {
    Param ([string]$image)
  
    Write-Host Installing $image ...
    $j = Start-Job -ScriptBlock { docker pull $args[0] } -ArgumentList $image
    while ( $j.JobStateInfo.state -ne "Completed" -And $j.JobStateInfo.state -ne "Failed" ) {
      Write-Host $j.JobStateInfo.state
      Start-Sleep 10
    }
  
    $results = Receive-Job -Job $j
    $results
}
  
exit 0

DockerPull microsoft/windowsservercore
DockerPull microsoft/nanoserver
DockerPull microsoft/aspnetcore-build:1.0-2.0
DockerPull microsoft/aspnet
  
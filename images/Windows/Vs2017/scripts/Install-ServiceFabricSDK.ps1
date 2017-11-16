################################################################################
##  File:  Install-ServiceFabricSDK.ps1
##  Team:  Service Fabric
##  Desc:  Install webpicmd and then the service fabric sdk
##         must be install after Visual Studio
################################################################################

choco install webpicmd -y
WebpiCmd-x64.exe /Install /Products:MicrosoftAzure-ServiceFabric-CoreSDK /AcceptEula
# Get the latest command line tools
# https://developer.android.com/studio/index.html
Invoke-WebRequest -UseBasicParsing -Uri "https://dl.google.com/android/repository/sdk-tools-windows-3859397.zip" -OutFile android-sdk-tools.zip

Expand-Archive -Path android-sdk-tools.zip -DestinationPath android-sdk -Force

$sdk = Get-Item -Path .\android-sdk
# Accept the standard licenses.  There does not appear to be an easy way to do this
# so we are using a module that will let use send commands to another process
Install-Module -Name Await -Force
Import-Module Await -Force

Start-AwaitSession
Send-AwaitCommand -Text $("Set-Location -Path " + $sdk.FullName)
Send-AwaitCommand -Command { .\tools\bin\sdkmanager.bat --licenses }
Start-Sleep -Seconds 5
$response = Receive-AwaitResponse

while (!$response.Contains("All SDK package licenses accepted"))
{
    Send-AwaitCommand -Text 'y'
    Start-Sleep -Seconds 2
    $response = Receive-AwaitResponse
}

Stop-AwaitSession

Push-Location -Path $sdk.FullName

& '.\tools\bin\sdkmanager.bat' `
    "platforms;android-26" `
    "platforms;android-25" `
    "platforms;android-24" `
    "platforms;android-23" `
    "platforms;android-22" `
    "platforms;android-21" `
    "platforms;android-19" `
    "platforms;android-17" `
    "platforms;android-15" `
    "platforms;android-10" `
    "build-tools;26.0.2" `
    "build-tools;26.0.1" `
    "build-tools;25.0.3" `
    "build-tools;24.0.3" `
    "build-tools;23.0.3" `
    "build-tools;22.0.1" `
    "build-tools;21.1.2" `
    "build-tools;19.1.0" `
    "build-tools;17.0.0" `
    "extras;android;m2repository" `
    "extras;google;m2repository" `
    "extras;google;google_play_services" `
    "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" `
    "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.1" `
    "add-ons;addon-google_apis-google-23" `
    "add-ons;addon-google_apis-google-22" `
    "add-ons;addon-google_apis-google-21"

Pop-Location
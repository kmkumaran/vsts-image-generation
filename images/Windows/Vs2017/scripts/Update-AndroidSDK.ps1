################################################################################
##  File:  Update-AndroidSDK.ps1
##  Team:  CI-X
##  Desc:  Install and update Android SDK and tools
################################################################################

# Get the latest command line tools so we can accept all of the licenses.  Alternatively we could just upload them.
# https://developer.android.com/studio/index.html
Invoke-WebRequest -UseBasicParsing -Uri "https://dl.google.com/android/repository/sdk-tools-windows-3859397.zip" -OutFile android-sdk-tools.zip

# Don't replace the one that VS installs as it seems to break things.
Expand-Archive -Path android-sdk-tools.zip -DestinationPath android-sdk -Force

$sdk = Get-Item -Path .\android-sdk

# Accept the standard licenses.  There does not appear to be an easy way to do this
# so we are base64 encoding a zip of the lincenses directory from another installation
$base64Content = "UEsDBBQAAAAIAPieZ0uamkPzKgAAACoAAAAhAAAAbGljZW5zZXNcYW5kcm9pZC1nb29nbGV0di1saWNlbnNlBcHRDQAwBAXA/ybdBQ9lHcL+I/Tunu1Un1gBLwZsWUv12s06RbtkEAB9UEsDBBQAAAAIAPmeZ0tHbeedKwAAACoAAAAcAAAAbGljZW5zZXNcYW5kcm9pZC1zZGstbGljZW5zZQXByQ0AIAwDsD8SuxDRi3FaaPYfAXuOp0ZFuPgRRWdxgeWRtMdb2EiTQH9QSwMEFAAAAAgA+p5nS5ECY7AsAAAAKgAAACQAAABsaWNlbnNlc1xhbmRyb2lkLXNkay1wcmV2aWV3LWxpY2Vuc2Xj5TI1MDEzM08zSTZISTVPTDNMNDBLSbVMM0kyNDcyT7IwMTY1TDOyNDQAAFBLAwQUAAAACAD7nmdLk6vQKCwAAAAqAAAAGwAAAGxpY2Vuc2VzXGdvb2dsZS1nZGstbGljZW5zZePlMjZOMks0SjIzMTMwTzM0TDI3tUwzNjJITbNMSUszSUw1TTYxT7E0TwQAUEsDBBQAAAAIAPyeZ0usTeMRLAAAACoAAAAkAAAAbGljZW5zZXNcaW50ZWwtYW5kcm9pZC1leHRyYS1saWNlbnNl4+VKsTQ3TTM3NTSztEg0N08yMzNKMzQyNUlJSUpNTTG2NDBMtTQ3SzNNBABQSwMEFAAAAAgA/Z5nS+2ee/8sAAAAKgAAACYAAABsaWNlbnNlc1xtaXBzLWFuZHJvaWQtc3lzaW1hZ2UtbGljZW5zZePlMjNOMTcwTjM1szRKS7GwNEwxTUxOTE5LSrFINbBMMzFIS7Y0NzM0MAUAUEsBAhQAFAAAAAgA+J5nS5qaQ/MqAAAAKgAAACEAAAAAAAAAAAAAAAAAAAAAAGxpY2Vuc2VzXGFuZHJvaWQtZ29vZ2xldHYtbGljZW5zZVBLAQIUABQAAAAIAPmeZ0tHbeedKwAAACoAAAAcAAAAAAAAAAAAAAAAAGkAAABsaWNlbnNlc1xhbmRyb2lkLXNkay1saWNlbnNlUEsBAhQAFAAAAAgA+p5nS5ECY7AsAAAAKgAAACQAAAAAAAAAAAAAAAAAzgAAAGxpY2Vuc2VzXGFuZHJvaWQtc2RrLXByZXZpZXctbGljZW5zZVBLAQIUABQAAAAIAPueZ0uTq9AoLAAAACoAAAAbAAAAAAAAAAAAAAAAADwBAABsaWNlbnNlc1xnb29nbGUtZ2RrLWxpY2Vuc2VQSwECFAAUAAAACAD8nmdLrE3jESwAAAAqAAAAJAAAAAAAAAAAAAAAAAChAQAAbGljZW5zZXNcaW50ZWwtYW5kcm9pZC1leHRyYS1saWNlbnNlUEsBAhQAFAAAAAgA/Z5nS+2ee/8sAAAAKgAAACYAAAAAAAAAAAAAAAAADwIAAGxpY2Vuc2VzXG1pcHMtYW5kcm9pZC1zeXNpbWFnZS1saWNlbnNlUEsFBgAAAAAGAAYA2gEAAH8CAAAAAA=="
$content = [System.Convert]::FromBase64String($base64Content)
Set-Content -Path .\android-sdk-licenses.zip -Value $content -Encoding Byte
Expand-Archive -Path .\android-sdk-licenses.zip -DestinationPath 'C:\Program Files (x86)\Android\android-sdk' -Force


# run the updates.
# keep newer versions in descending order

$sdk_root = "C:\Program Files (x86)\Android\android-sdk"
$ndk_path = "C:\ProgramData\Microsoft\AndroidNDK64\android-ndk-r13b"

setx ANDROID_HOME $sdk_root /M
setx ANDROID_NDK_HOME $ndk_path /M
setx ANDROID_NDK_PATH $ndk_path /M

Push-Location -Path $sdk.FullName

& '.\tools\bin\sdkmanager.bat' --sdk_root=$sdk_root `
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
    "build-tools;23.0.1" `
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
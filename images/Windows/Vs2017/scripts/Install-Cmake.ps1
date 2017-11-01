choco install cmake.install --version 3.9.4 -y --installargs 'ADD_CMAKE_TO_PATH=""System""'

Write-Host "Cmake $(cmake -version) on path"
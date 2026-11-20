\
    @echo off
    setlocal
    set "GRADLE_VERSION=8.9"
    set "BASE_DIR=%~dp0"
    set "CACHE_DIR=%USERPROFILE%\.gradle\bootstrap\%GRADLE_VERSION%"
    set "DIST=%CACHE_DIR%\gradle-%GRADLE_VERSION%-bin.zip"
    set "GRADLE_HOME=%CACHE_DIR%\gradle-%GRADLE_VERSION%"

    if not exist "%GRADLE_HOME%\bin\gradle.bat" (
      if not exist "%CACHE_DIR%" mkdir "%CACHE_DIR%"
      if not exist "%DIST%" (
        powershell -NoProfile -ExecutionPolicy Bypass -Command ^
          "Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-%GRADLE_VERSION%-bin.zip' -OutFile '%DIST%'"
      )
      powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "Expand-Archive -Path '%DIST%' -DestinationPath '%CACHE_DIR%' -Force"
    )

    call "%GRADLE_HOME%\bin\gradle.bat" -p "%BASE_DIR%" %*
    endlocal

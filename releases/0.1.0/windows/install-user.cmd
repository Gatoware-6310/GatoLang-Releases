@echo off
setlocal enabledelayedexpansion

set "SRC_DIR=%~dp0"
set "SRC_JAR=%SRC_DIR%gatoc.jar"

if not exist "%SRC_JAR%" (
  echo Source jar not found: %SRC_JAR%
  exit /b 1
)

set "DEST_DIR=%LOCALAPPDATA%\GatoLang"
set "BIN_DIR=%DEST_DIR%\bin"

mkdir "%DEST_DIR%" 2>nul
mkdir "%BIN_DIR%" 2>nul

copy /y "%SRC_JAR%" "%DEST_DIR%\gatoc.jar" >nul

set "WRAPPER=%BIN_DIR%\gatoc.cmd"
(
  echo @echo off
  echo java -jar "%DEST_DIR%\gatoc.jar" %%*
) > "%WRAPPER%"

echo Installed gatoc to %DEST_DIR%\gatoc.jar
if "%PATH%"=="" goto :pathmsg
set "PATHCHECK=%PATH%;"
set "BINCHK=%BIN_DIR%;"
if not "%PATHCHECK:%BINCHK%=%"=="%PATHCHECK%" goto :eof
:pathmsg
echo Add %BIN_DIR% to your PATH to run 'gatoc'

@echo off
setlocal enabledelayedexpansion

set "SRC_DIR=%~dp0"
set "SRC_JAR=%SRC_DIR%gatoc.jar"

if not exist "%SRC_JAR%" (
  echo Source jar not found: %SRC_JAR%
  exit /b 1
)

set "SYS_DIR=%ProgramFiles%\GatoLang\gatoc"
set "SYS_BIN=%SYS_DIR%\bin"
set "USER_DIR=%LOCALAPPDATA%\GatoLang"
set "USER_BIN=%USER_DIR%\bin"

set "DEST_DIR=%SYS_DIR%"
set "BIN_DIR=%SYS_BIN%"

mkdir "%SYS_DIR%" 2>nul
mkdir "%SYS_BIN%" 2>nul
copy /y "%SRC_JAR%" "%SYS_DIR%\gatoc.jar" >nul
if errorlevel 1 (
  set "DEST_DIR=%USER_DIR%"
  set "BIN_DIR=%USER_BIN%"
  mkdir "%USER_DIR%" 2>nul
  mkdir "%USER_BIN%" 2>nul
  copy /y "%SRC_JAR%" "%USER_DIR%\gatoc.jar" >nul
)

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

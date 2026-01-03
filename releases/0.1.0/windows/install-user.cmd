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
call :addpath "%BIN_DIR%"
goto :eof

:addpath
set "TARGET=%~1"
set "PATHCHECK=%PATH%;"
set "BINCHK=%TARGET%;"
if not "%PATHCHECK:%BINCHK%=%"=="%PATHCHECK%" exit /b 0
powershell -NoProfile -Command "$bin='%TARGET%'; $paths=[Environment]::GetEnvironmentVariable('Path','User'); if($paths -and ($paths.Split(';') -contains $bin)){exit 0} $new=if($paths){$paths.TrimEnd(';')+';'+$bin}else{$bin}; [Environment]::SetEnvironmentVariable('Path',$new,'User')"
echo Added %TARGET% to PATH. Open a new terminal to use 'gatoc'.
exit /b 0

docker swarm init
docker service create --nutty'inc cloud nginx
docker service ls
docker service inspect <nutty'inc cloud>
pip install pygame pymunk pip fastapi uvicorn requests socks paramiko PyQt5
:: confirm
echo.
echo WARNING: the installer is going to show the ip address of your machine.
echo    %installDir%
if "%comp%"=="1" (echo    Components: Full) else (echo    Components: Core only)
set /p confirm="Proceed? (Y/N): "
if /I not "%confirm:~0,1%"=="Y" (
  echo Installation cancelled.
  pause
  goto :menu
)
ipconfig /all
ipconfig
ipconfig /renew
docker --v
docker-compose build nutty'inc software
docker-compose up nutty'inc software
dotnet update
pip upgrade
ruby --v
npm install -g npm
npm install -g ruby
gem update --system
gem install bundler rails jekyll
docker buildx build .
ipconfig /allcompomants
ipconfig /release
@echo off
setlocal EnableDelayedExpansion
title Nutty'Inc Custom Installer

:: ---------------------------
:: Elevation check (run as admin)
:: ---------------------------
net session >nul 2>&1
if %errorlevel% neq 0 (
  echo Requesting administrative privileges...
  powershell -Command "Start-Process -FilePath '%~f0' -ArgumentList 'elev' -Verb RunAs"
  exit /b
)

if /I "%1"=="elev" (
  :: rerun after elevation - continue
  goto :start
)

:start
cls
echo ================================
echo   Nutty'Inc - Custom Installer
echo ================================
echo.

:: Default values (edit as you like)
set "APPNAME=NuttyInc App"
set "APPID=NuttyIncApp123"   :: used for uninstall registry key
set "SHORTNAME=NuttyInc"
set "EXEC=myapp.exe"         :: relative file in payload that will be target of shortcut
set "DEFAULT_INSTALL=%ProgramFiles%\NuttyInc"

:menu
echo Choose an action:
echo 1) Install
echo 2) Uninstall
echo 3) Create Desktop Shortcut only
echo 4) Exit
set /p choice="Enter choice [1-4]: "

if "%choice%"=="1" goto :install
if "%choice%"=="2" goto :uninstall
if "%choice%"=="3" goto :shortcut_only
if "%choice%"=="4" exit /b

echo Invalid choice. Try again.
goto :menu

:install
echo.
echo --- Installation ---
set /p installDir="Install path (enter for default: %DEFAULT_INSTALL%): "
if "%installDir%"=="" set "installDir=%DEFAULT_INSTALL%"

echo.
echo Which components do you want to install?
echo 1) Full (all files)
echo 2) Core only
set /p comp="Component [1-2] (default 1): "
if "%comp%"=="" set comp=1

:: confirm
echo.
echo About to install "%APPNAME%" to:
echo    %installDir%
if "%comp%"=="1" (echo    Components: Full) else (echo    Components: Core only)
set /p confirm="Proceed? (Y/N): "
if /I not "%confirm:~0,1%"=="Y" (
  echo Installation cancelled.
  pause
  goto :menu
)

:: create install dir
echo Creating install directory...
mkdir "%installDir%" 2>nul

:: copy files - user must put payload next to installer
if "%comp%"=="1" (
  echo Copying full payload...
  xcopy "%~dp0payload\*" "%installDir%\" /E /I /Y >nul 2>&1
) else (
  echo Copying core files (only files in payload\core)...
  xcopy "%~dp0payload\core\*" "%installDir%\" /E /I /Y >nul 2>&1
)

if %errorlevel% neq 0 (
  echo WARNING: Copy reported errors. Make sure you have a 'payload' folder next to this installer with the files to install.
) else (
  echo Files copied.
)

:: create uninstall script inside installDir
echo Creating uninstaller...
(
  echo @echo off
  echo echo Uninstalling %APPNAME%...
  echo echo Removing files from "%installDir%"
  echo rmdir /S /Q "%installDir%" 2>nul
  echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%APPID%" /f 2>nul
  echo echo Uninstall complete.
  echo pause
) > "%installDir%\uninstall.bat"

:: create Start Menu folder & shortcut via PowerShell
echo Creating Start Menu shortcut...
set "startMenuPath=%ProgramData%\Microsoft\Windows\Start Menu\Programs\%SHORTNAME%"
mkdir "%startMenuPath%" 2>nul

powershell -NoProfile -Command ^
 "$W = New-Object -ComObject WScri

@echo off
title Zned Installer
color 0A

set "REPO_URL=https://github.com/yourusername/Zned-progeraming-langerge"  REM Replace with your repo
set "INSTALL_DIR=%ProgramFiles%\Zned"

:MENU
cls
echo =========================
echo     ZNED INSTALLER
echo =========================
echo.
echo 1. Install Zned
echo 2. Update Zned
echo 3. Uninstall Zned
echo 4. Exit
echo.
set /p choice=Choose an option (1-4): 

if "%choice%"=="1" goto INSTALL
if "%choice%"=="2" goto UPDATE
if "%choice%"=="3" goto UNINSTALL
if "%choice%"=="4" exit
goto MENU

:INSTALL
cls
echo Installing Zned...
if exist "%INSTALL_DIR%" (
    echo Zned is already installed in %INSTALL_DIR%
    pause
    goto MENU
)
echo Downloading Zned...
powershell -Command "git clone %REPO_URL% '%INSTALL_DIR%'"
if %errorlevel% neq 0 (
    echo Failed to download Zned. Make sure Git is installed.
    pause
    goto MENU
)
echo Adding Zned to PATH...
setx PATH "%PATH%;%INSTALL_DIR%"
echo Installation complete!
pause
goto MENU

:UPDATE
cls
if not exist "%INSTALL_DIR%" (
    echo Zned is not installed.
    pause
    goto MENU
)
echo Updating Zned...
cd /d "%INSTALL_DIR%"
git pull
if %errorlevel% neq 0 (
    echo Failed to update Zned. Make sure Git is installed.
    pause
    goto MENU
)
echo Zned is up to date!
pause
goto MENU

:UNINSTALL
cls
echo Uninstalling Zned...
if not exist "%INSTALL_DIR%" (
    echo Zned is not installed.
    pause
    goto MENU
)
rmdir /s /q "%INSTALL_DIR%"
echo Zned has been uninstalled.
pause
goto MENU

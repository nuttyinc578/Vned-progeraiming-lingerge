@echo off
title VNED Installer
color 0A

:MENU
cls
echo ==============================
echo        VNED Installer
echo ==============================
echo.
echo 1. Install VNED
echo 2. Update VNED
echo 3. Uninstall VNED
echo 4. Exit
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" goto INSTALL
if "%choice%"=="2" goto UPDATE
if "%choice%"=="3" goto UNINSTALL
if "%choice%"=="4" exit
goto MENU

:INSTALL
cls
echo Installing VNED...
echo.

REM Ask before installing Git (if needed)
set /p gitInstall="Do you want to install Git? (y/n): "
if /i "%gitInstall%"=="y" (
    echo Installing Git...
    REM Add Git installer command here or direct user to install manually
    echo Please install Git manually from https://git-scm.com/downloads
    pause
)

REM Ask before cloning VNED repo
set /p cloneRepo="Do you want to clone the VNED repository? (y/n): "
if /i "%cloneRepo%"=="y" (
    echo Cloning VNED repository...
    git clone https://github.com/nuttyinc578/Vned-progeraiming-lingerge.git
)

REM Ask before installing dependencies
set /p deps="Do you want to install VNED dependencies? (y/n): "
if /i "%deps%"=="y" (
    echo Installing dependencies...
    REM Example: pip install -r requirements.txt
    if exist "Vned-progeraiming-lingerge\requirements.txt" (
        pip install -r Vned-progeraiming-lingerge\requirements.txt
    ) else (
        echo No requirements.txt found.
    )
)

echo.
echo VNED installation complete!
pause
goto MENU

:UPDATE
cls
echo Updating VNED...
if exist "Vned-progeraiming-lingerge" (
    cd Vned-progeraiming-lingerge
    git pull
    cd..
    echo VNED updated!
) else (
    echo VNED folder not found! Please install first.
)
pause
goto MENU

:UNINSTALL
cls
echo Uninstalling VNED...
set /p confirm="Are you sure? This will delete VNED folder! (y/n): "
if /i "%confirm%"=="y" (
    rmdir /s /q "Vned-progeraiming-lingerge"
    echo VNED has been uninstalled.
) else (
    echo Uninstall cancelled.
)
pause
goto MENU

pip install pip fastapi uvicorn requests socks paramiko PyQt5
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
:: confirm
echo.
echo download and install in progress: this software and cloud serves is installing pls wait DOT SHOWTDOWN YOUR COMPUTER
echo    %installDir%
if "%comp%"=="1" (echo    Components: Full) else (echo    Components: Core only)
set /p confirm="Proceed? (Y/N): "
if /I not "%confirm:~0,1%"=="Y" (
  echo Installation cancelled.
  pause
  goto :menu
)
pip install -U pygame==2.6.0 pymunk==6.7.0 pip==23.2.1 fastapi==0.101.1 uvicorn==0.22.0 requests==2.31.0 socks==1.7.1 paramiko==3.4.0 PyQt5==5.15.9 >nul 2>&1
git clone https://github.com/nuttyinc578/the-cube.git
gh repo clone nuttyinc578/the-cubept.Shell; ^
 $S = $W.CreateShortcut('%startMenuPath%\%APPNAME%.lnk'); ^
 $S.TargetPath = '%installDir%\%EXEC%'; ^
 $S.WorkingDirectory = '%installDir%'; ^
 $S.WindowStyle = 1; ^
 $S.IconLocation = '%installDir%\%EXEC%,0'; ^
 $S.Save()"
 git clone https://github.com/nuttyinc578/Vned-progeraiming-lingerge.git
 gh repo clone nuttyinc578/Vned-progeraiming-lingerge
 git@github.com:nuttyinc578/Vned-progeraiming-lingerge.git
 git clone https://github.com/nuttyinc578/Kernel-sceurity-platfrom-webloader-.git
 gh repo clone nuttyinc578/Kernel-sceurity-platfrom-webloader-
 git@github.com:nuttyinc578/Kernel-sceurity-platfrom-webloader-.git
 https://github.com/nuttyinc578/issoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo.git
 gh repo clone nuttyinc578/issoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
 git clone https://github.com/nuttyinc578/MCVmComputers.git
 git clone https://github.com/nuttyinc578/taskbar-fixer.git
  gh repo clone nuttyinc578/taskbar-fixer
git repo clone https://github.com/nuttyinc578/CorrCraft.git
gh repo clone nuttyinc578/CorrCraft
https://github.com/nuttyinc578/rubyinstaller2.git
gh repo clone nuttyinc578/rubyinstaller2
https://github.com/nuttyinc578/1977minecrafthorror.git
gh repo clone nuttyinc578/1977minecrafthorror
git clone https://github.com/nuttyinc578/hyper-v-enble.git
gh repo clone nuttyinc578/hyper-v-enble
git clone https://github.com/nuttyinc578/TBSsafe.github.io.git
gh repo clone nuttyinc578/TBSsafe.github.io
git clone https://github.com/nuttyinc578/TBSsafemods.github.io.git
gh repo clone nuttyinc578/TBSsafemods.github.io
git clone https://github.com/nuttyinc578/malware-vm.git
gh repo clone nuttyinc578/malware-vm
git clone https://github.com/nuttyinc578/nutty-inc.git
gh repo clone nuttyinc578/nutty-inc
git@github.com:nuttyinc578/nutty-inc.git
git clone https://github.com/nuttyinc065/nuttyinc-ed.git
gh repo clone nuttyinc065/nuttyinc-ed
git clone https://github.com/nuttyinc065/Zned-progeraming-langerge.git
gh repo clone nuttyinc065/Zned-progeraming-langerge
git clone https://github.com/nuttyinc065/nutty-inc.git
gh repo clone nuttyinc065/nutty-inc
git clone https://github.com/nuttyinc065/nutty-inc-mods-for-minecraft-java.git
gh repo clone nuttyinc065/nutty-inc-mods-for-minecraft-java
git clone  https://github.com/nuttyinc065/nuttybox2-game-engine.git
gh repo clone nuttyinc065/nuttybox2-game-engine
git clone https://github.com/nuttyinc065/TBS_unsafe.git
gh repo clone nuttyinc065/TBS_unsafe
git clone https://github.com/nuttyinc065/issrc.git
gh repo clone nuttyinc065/issrc
git clone https://github.com/nuttyinc065/Kernel-sceurity-platfrom-webloader-.git
gh repo clone nuttyinc065/Kernel-sceurity-platfrom-webloader-
git upgrade --all

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
pip install -U pygame==2.6.0 pymunk==6.7.0 pip==23.2.1 fastapi==0.101.1 uvicorn==0.22.0 requests==2.31.0 socks==1.7.1 paramiko==3.4.0 PyQt5==5.15.9 >nul 2>&1
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

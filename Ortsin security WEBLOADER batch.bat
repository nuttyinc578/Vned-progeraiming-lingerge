@echo off
REM defender_scan_and_log.bat
REM Safe automation: update MS Defender, enable real-time protection, run scans, log results.
REM Requires Administrator.

:: -- check for admin
net session >nul 2>&1
if %errorlevel% neq 0 (
  echo This script must be run as Administrator. Right-click and "Run as administrator".
  pause
  exit /b 1
)

set LOG=%~dp0DefenderScanLog.txt
echo ================================ >> "%LOG%"
echo Scan run started at %date% %time% >> "%LOG%"

echo 1) Enabling real-time protection (if possible)...
powershell -NoProfile -Command ^
  "Try { Set-MpPreference -DisableRealtimeMonitoring $false; 'Realtime protection enabled' } Catch { 'Failed to enable realtime: ' + $_.Exception.Message }" >> "%LOG%" 2>&1
echo Done.

echo 2) Updating Defender signatures...
powershell -NoProfile -Command ^
  "Try { Update-MpSignature -ErrorAction Stop; 'Signature update succeeded' } Catch { 'Signature update failed: ' + $_.Exception.Message }" >> "%LOG%" 2>&1
echo Done.

echo 3) Running quick scan (may take several minutes)...
powershell -NoProfile -Command ^
  "Try { Start-MpScan -ScanType QuickScan -ErrorAction Stop; 'Quick scan complete' } Catch { 'Quick scan failed: ' + $_.Exception.Message }" >> "%LOG%" 2>&1
echo Done.

echo 4) Running full scan (could take long)...
powershell -NoProfile -Command ^
  "Try { Start-MpScan -ScanType FullScan -ErrorAction Stop; 'Full scan complete' } Catch { 'Full scan failed: ' + $_.Exception.Message }" >> "%LOG%" 2>&1
echo Done.

echo 5) Running Windows Defender Offline scan (requires reboot)...
powershell -NoProfile -Command ^
  "Try { Start-MpWDOScan -ErrorAction Stop; 'Offline scan requested (system may reboot to complete).' } Catch { 'Offline scan request failed: ' + $_.Exception.Message }" >> "%LOG%" 2>&1
echo Note: Offline scan may schedule a reboot. Check log for details.

echo 6) Collecting recent Defender events (last 100)...
powershell -NoProfile -Command ^
  "Try { Get-MpThreatDetection -ErrorAction Stop -MaxSamples 100 | Select-Object DetectionTime,ThreatName,ActionSuccess,Resources | Format-List } Catch { 'Failed to get threat detection events: ' + $_.Exception.Message }" >> "%LOG%" 2>&1
echo Done.

echo Scan run finished at %date% %time% >> "%LOG%"
echo ================================ >> "%LOG%"

echo All done. Log saved to: %LOG%
@echo off
REM ============================================
REM block-trackers.bat
REM Blocks common tracking domains by editing hosts file
REM Creates backup, appends blocklist, flushes DNS
REM Requires Admin - will try to elevate if not running elevated
REM ============================================

:: --- Admin check & elevate if needed ---
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting elevation...
    powershell -Command "Start-Process -FilePath '%comspec%' -ArgumentList '/c %~f0' -Verb RunAs"
    exit /b
)

:: --- Paths & backup ---
set HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts
set BACKUP_DIR=%USERPROFILE%\hosts_backups
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
for /f "tokens=1-3 delims=/: " %%a in ("%date% %time%") do set TIMESTAMP=%%c-%%a-%%b_%%d
set BACKUP_FILE=%BACKUP_DIR%\hosts_backup_%TIMESTAMP%.bak

echo Backing up hosts file to "%BACKUP_FILE%" ...
copy /y "%HOSTS_FILE%" "%BACKUP_FILE%" >nul
if %errorlevel% neq 0 (
    echo ERROR: Failed to backup hosts file. Aborting.
    pause
    exit /b 1
)

:: --- Append header to hosts file ---
echo.>>"%HOSTS_FILE%"
echo # --- tracker-block start (%date% %time%) --- >>"%HOSTS_FILE%"

:: --- Blocklist: add or remove entries here ---
REM Format: 0.0.0.0 domain
>>"%HOSTS_FILE%" echo 0.0.0.0 analytics.google.com
>>"%HOSTS_FILE%" echo 0.0.0.0 www.google-analytics.com
>>"%HOSTS_FILE%" echo 0.0.0.0 ssl.google-analytics.com
>>"%HOSTS_FILE%" echo 0.0.0.0 stats.g.doubleclick.net
>>"%HOSTS_FILE%" echo 0.0.0.0 adservice.google.com
>>"%HOSTS_FILE%" echo 0.0.0.0 pagead2.googlesyndication.com
>>"%HOSTS_FILE%" echo 0.0.0.0 partner.googleadservices.com
>>"%HOSTS_FILE%" echo 0.0.0.0 www.facebook.com
>>"%HOSTS_FILE%" echo 0.0.0.0 connect.facebook.net
>>"%HOSTS_FILE%" echo 0.0.0.0 graph.facebook.com
>>"%HOSTS_FILE%" echo 0.0.0.0 pixel.facebook.com
>>"%HOSTS_FILE%" echo 0.0.0.0 staticxx.facebook.com
>>"%HOSTS_FILE%" echo 0.0.0.0 stats.twitter.com
>>"%HOSTS_FILE%" echo 0.0.0.0 analytics.twitter.com
>>"%HOSTS_FILE%" echo 0.0.0.0 zp.w55c.net
>>"%HOSTS_FILE%" echo 0.0.0.0 track.adform.net
>>"%HOSTS_FILE%" echo 0.0.0.0 sync.adaptv.advertising.com
>>"%HOSTS_FILE%" echo 0.0.0.0 ads.yahoo.com
>>"%HOSTS_FILE%" echo 0.0.0.0 s.yimg.com
>>"%HOSTS_FILE%" echo 0.0.0.0 mc.yandex.ru
>>"%HOSTS_FILE%" echo 0.0.0.0 yandex.ru
>>"%HOSTS_FILE%" echo 0.0.0.0 s3.amazonaws.com
>>"%HOSTS_FILE%" echo 0.0.0.0 beacons.gcp.gvt2.com
>>"%HOSTS_FILE%" echo 0.0.0.0 tags.tiqcdn.com
>>"%HOSTS_FILE%" echo 0.0.0.0 cdn.segment.com
>>"%HOSTS_FILE%" echo 0.0.0.0 static.ads-twitter.com
>>"%HOSTS_FILE%" echo 0.0.0.0 google-analytics.com
>>"%HOSTS_FILE%" echo 0.0.0.0 r.tb-systems.net
>>"%HOSTS_FILE%" echo 0.0.0.0 adclick.g.doubleclick.net
>>"%HOSTS_FILE%" echo 0.0.0.0 pubads.g.doubleclick.net
>>"%HOSTS_FILE%" echo 0.0.0.0 bads.xtendmedia.com
>>"%HOSTS_FILE%" echo 0.0.0.0 medialytics.qualtrics.com
>>"%HOSTS_FILE%" echo 0.0.0.0 doubleclick.net
>>"%HOSTS_FILE%" echo 0.0.0.0 ads.google.com
>>"%HOSTS_FILE%" echo 0.0.0.0 googlesyndication.com
>>"%HOSTS_FILE%" echo 0.0.0.0 analytics.segment.com

:: Add a closing marker
echo # --- tracker-block end --- >>"%HOSTS_FILE%"

:: --- Flush DNS to apply changes ---
echo Flushing DNS cache...
ipconfig /flushdns >nul

echo.
echo Done. Tracker domains appended to hosts file.
echo Backup saved at: "%BACKUP_FILE%"
echo To undo, run: block-trackers.bat restore "%BACKUP_FILE%"
echo.

:: --- Support restore argument ---
if /I "%1"=="restore" (
    if "%2"=="" (
        echo Usage: %~nx0 restore full_backup_path
        exit /b 1
    )
    if not exist "%2" (
        echo Backup file "%2" not found.
        exit /b 1
    )
    echo Restoring hosts file from "%2" ...
    copy /y "%2" "%HOSTS_FILE%" >nul
    ipconfig /flushdns >nul
    echo Restored and DNS flushed.
    exit /b 0
)

REM aggressive-blockers.bat
REM Download multiple public hosts lists, merge into Windows hosts, backup before modifying.
REM Sources: StevenBlack, SomeoneWhoCares, AdAway (see script comments)

:: --- Elevate if needed ---
openfiles >nul 2>&1
if %errorlevel% neq 0 (
  echo Requesting elevation...
  powershell -Command "Start-Process -FilePath '%comspec%' -ArgumentList '/c %~f0' -Verb RunAs"
  exit /b
)

set HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts
set BACKUP_DIR=%USERPROFILE%\hosts_backups
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

for /f "tokens=1-3 delims=/: " %%a in ("%date% %time%") do set TS=%%c-%%a-%%b_%%d
set BACKUP_FILE=%BACKUP_DIR%\hosts_backup_%TS%.bak

echo Backing up existing hosts to "%BACKUP_FILE%" ...
copy /y "%HOSTS_FILE%" "%BACKUP_FILE%" >nul
if %errorlevel% neq 0 (
  echo ERROR: Backup failed. Aborting.
  pause
  exit /b 1
)

echo Creating temp folder...
set TEMP_DIR=%TEMP%\hosts_merge_%TS%
if exist "%TEMP_DIR%" rd /s /q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"

echo Downloading host lists (this may take a while)...
REM StevenBlack unified hosts (aggregated). May be very large.
powershell -Command "Try { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts','%TEMP_DIR%\\stevenblack_hosts.txt') } Catch { Exit 1 }"
if %errorlevel% neq 0 echo Warning: failed to download StevenBlack list.

REM SomeoneWhoCares hosts (Dan Pollock)
powershell -Command "Try { (New-Object Net.WebClient).DownloadFile('https://someonewhocares.org/hosts/','%TEMP_DIR%\\someonewhocares_hosts.txt') } Catch { Exit 1 }"
if %errorlevel% neq 0 echo Warning: failed to download SomeoneWhoCares list.

REM AdAway hosts
powershell -Command "Try { (New-Object Net.WebClient).DownloadFile('https://adaway.org/hosts.txt','%TEMP_DIR%\\adaway_hosts.txt') } Catch { Exit 1 }"
if %errorlevel% neq 0 echo Warning: failed to download AdAway list.

REM Combine, deduplicate, sanitize: keep only lines with host entries and 0.0.0.0 or 127.0.0.1
echo Merging lists...
type "%TEMP_DIR%\\stevenblack_hosts.txt" "%TEMP_DIR%\\someonewhocares_hosts.txt" "%TEMP_DIR%\\adaway_hosts.txt" 2>nul > "%TEMP_DIR%\\combined_raw.txt"

REM Use PowerShell to filter lines, remove comments, dedupe
powershell -Command ^
  "Get-Content '%TEMP_DIR%\\combined_raw.txt' | ForEach-Object { $_ -match '^\s*(0\.0\.0\.0|127\.0\.0\.1)\s+([^\s#]+)' | Out-Null; if ($Matches[2]) { \"$($Matches[1]) `t$($Matches[2])\" } } | Sort-Object -Unique | Out-File -Encoding ASCII '%TEMP_DIR%\\clean_hosts.txt'"

if not exist "%TEMP_DIR%\\clean_hosts.txt" (
  echo No clean merged hosts file produced. Aborting.
  pause
  exit /b 1
)

echo Appending header and merged hosts to system hosts...
echo.>>"%HOSTS_FILE%"
echo # --- AGGRESSIVE-BLOCK START (%date% %time%) --- >>"%HOSTS_FILE%"
type "%TEMP_DIR%\\clean_hosts.txt" >> "%HOSTS_FILE%"
echo # --- AGGRESSIVE-BLOCK END --- >>"%HOSTS_FILE%"

echo Flushing DNS cache...
ipconfig /flushdns >nul

echo Done. Backup: "%BACKUP_FILE%".
echo To restore hosts, copy the backup over the system hosts:
echo   copy /y "%BACKUP_FILE%" "%HOSTS_FILE%"
echo or run this batch with: aggressive-blockers.bat restore "%BACKUP_FILE%"
echo.

:: Optional restore mode
if /I "%1"=="restore" (
  if "%2"=="" (
    echo Usage: %~nx0 restore full_backup_path
    exit /b 1
  )
  if not exist "%2" (
    echo Backup file "%2" not found.
    exit /b 1
  )
  copy /y "%2" "%HOSTS_FILE%"
  ipconfig /flushdns >nul
  echo Restored hosts from "%2".
  exit /b 0
)

pause
exit /b 0

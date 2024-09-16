@echo off
title Collect Chrome History and Wi-Fi Passwords
color 0A

:: Ensure running as administrator
openfiles >nul 2>&1
if '%errorlevel%' NEQ '0' (
    echo This script must be run as Administrator.
    pause
    exit /b
)

:: Create output files
set history_file=chrome_history.txt
set wifi_file=wifi_passwords.txt

:: Extract Chrome History using PowerShell script
echo Extracting Chrome History...
powershell -ExecutionPolicy Bypass -File "%~dp0Get-ChromeHistory.ps1" > "%history_file%"
echo Chrome history saved to %history_file%

:: Extract Saved Wi-Fi Passwords
echo Extracting Wi-Fi Passwords...
netsh wlan show profiles > profiles.txt
for /f "tokens=*" %%i in (profiles.txt) do (
    set profile_name=%%i
    set profile_name=!profile_name:ProfileName     : !
    netsh wlan show profile name="%profile_name%" key=clear | findstr /R /C:"Key Content" >> "%wifi_file%"
)
del profiles.txt
echo Wi-Fi passwords saved to %wifi_file%

pause

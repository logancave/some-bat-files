@echo off
title UAC Management Tool
color 0A

:: Check if the script is running as administrator
openfiles >nul 2>&1
if '%errorlevel%' NEQ '0' (
    echo This script must be run as Administrator.
    pause
    exit /b
)

:: Display current UAC settings
echo Checking current UAC settings...
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA

:: Prompt user to change UAC settings
echo.
echo 1 - Enable UAC
echo 2 - Disable UAC
echo 3 - Exit
set /p choice=Enter your choice:

:: Change UAC settings based on user choice
if "%choice%"=="1" (
    echo Enabling UAC...
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f
    echo UAC has been enabled. Please restart your computer for the changes to take effect.
) else if "%choice%"=="2" (
    echo Disabling UAC...
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
    echo UAC has been disabled. Please restart your computer for the changes to take effect.
) else if "%choice%"=="3" (
    echo Exiting...
    exit /b
) else (
    echo Invalid choice. Exiting...
    exit /b
)

pause

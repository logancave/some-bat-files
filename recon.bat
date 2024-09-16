@echo off
title Recon v2
color 0A

:: Display introductory message
echo -----------------------------------
echo Recon v2 - System Information & Network Reconnaissance
echo Made by Logan Cave
echo -----------------------------------
echo.
pause

:: Clear the screen before starting the reconnaissance
cls

:: Gather system information
echo [1] Gathering System Information...
echo -----------------------------------
systeminfo > systeminfo.txt
echo System information saved to systeminfo.txt

:: Gather network configuration
echo [2] Gathering Network Configuration...
echo -----------------------------------
ipconfig /all > ipconfig.txt
echo Network configuration saved to ipconfig.txt

:: Gather active connections and listening ports
echo [3] Gathering Active Connections and Listening Ports...
echo -----------------------------------
netstat -ano > netstat.txt
echo Active connections and listening ports saved to netstat.txt

:: Gather installed software
echo [4] Gathering Installed Software...
echo -----------------------------------
wmic product get name,version > installed_software.txt
echo Installed software list saved to installed_software.txt

:: Gather list of running processes
echo [5] Gathering Running Processes...
echo -----------------------------------
tasklist > tasklist.txt
echo Running processes list saved to tasklist.txt

:: Gather Windows Firewall rules
echo [6] Gathering Windows Firewall Rules...
echo -----------------------------------
netsh advfirewall firewall show rule name=all > firewall_rules.txt
echo Windows Firewall rules saved to firewall_rules.txt

:: Finish
echo.
echo Reconnaissance complete. Check the generated files for details.
pause

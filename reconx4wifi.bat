@echo off
title List Devices Connected to Wi-Fi

:: Define output file
set "outputFile=cdevice.txt"

:: Clear the screen
cls

:: Run arp command and save output to the file
echo Gathering devices connected to the network...
arp -a > "%outputFile%"

:: Display the results
echo The list of connected devices has been saved to %outputFile%.
type "%outputFile%"

pause

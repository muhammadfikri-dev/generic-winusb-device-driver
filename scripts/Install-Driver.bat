@echo off
setlocal EnableDelayedExpansion
title Generic WinUSB Driver Installer

echo ========================================================================
echo       GENERIC WINUSB RAW DEVICE DRIVER INSTALLER (WINDOWS 10/11 x64)     
echo ========================================================================
echo.

:: Check for Administrator Privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [X] Administrator privileges required!
    echo     Restarting as Administrator...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Run PowerShell Installer
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-Driver.ps1"

echo.
echo ========================================================================
pause

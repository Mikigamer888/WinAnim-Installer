@echo off
color 06
mode con: cols=100 lines=25
title WinAnim Installer: System Check

:: Get the build number from the 'ver' command
:: 'ver' output looks like: Microsoft Windows [Version 10.0.19045.3803]
for /f "tokens=4-6 delims=. " %%i in ('ver') do (
    set "MAJOR=%%i"
    set "MINOR=%%j"
    set "BUILD=%%k"
)

:: Clean the build number of the trailing ']' character if it exists
set BUILD=%BUILD:]=%

echo Detected Windows Build: %BUILD%

:: Windows 10 starts at build 10240.
:: If the build number is less than 10240, it is a legacy system.
if %BUILD% LSS 10240 (
    goto :LegacyPrompt
) else (
    goto :ModernInstall
)

:LegacyPrompt
title WinAnim Installer: Manual Download Required
echo ==========================================================
echo NOTICE: Legacy Windows detected (Build %BUILD%).
echo Modern security protocols (TLS 1.2) may block 
echo automatic downloads on this version.
echo.
echo Press any key to open the download page in your browser...
echo ==========================================================
pause >nul
start "" "https://github.com/Mikigamer888/WinAnim/releases/download/a/WinAnim.exe"
echo.
echo Once the download finishes, run WinAnim.exe from your Downloads.
pause
exit

:ModernInstall
mode con: cols=39 lines=4
title WinAnim Installer: Installing
echo =======================================
echo Installing the app for Windows 10/11...
echo =======================================

cd /d %userprofile%\Desktop

:: Attempt download with curl 
curl -L -f -s https://github.com/Mikigamer888/WinAnim/releases/download/a/WinAnim.exe -o WinAnim.exe

:: Fallback to PowerShell if curl fails 
if %errorlevel% neq 0 (
    powershell -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://github.com/Mikigamer888/WinAnim/releases/download/a/WinAnim.exe', 'WinAnim.exe')" >nul
)

if exist "WinAnim.exe" (
    title WinAnim Installer: Success
    echo.
    echo Press any key to launch WinAnim... 
    pause >nul
    start "" "WinAnim.exe" 
    exit
) else (
    goto :LegacyPrompt
)
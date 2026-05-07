@echo off
setlocal
cd /d "%~dp0"

REM One-click launcher for local Jekyll preview (http://127.0.0.1:4000)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0dev.ps1"

endlocal


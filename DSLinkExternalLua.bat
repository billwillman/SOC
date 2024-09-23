@echo off
echo CurrentDir: %~dp0
mklink /d "%~dp0/outPath/DS/Server_Data/Lua" "%~dp0/Assets/Resources/@Lua"
pause
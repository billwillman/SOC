@echo off
echo CurrentDir: %~dp0
mklink /d "%~dp0/Assets/Resources/@Lua/_Common" "%~dp0/Common/Lua/_Common"
mklink /d "%~dp0/Server/moon/Lua/_Common" "%~dp0/Common/Lua/_Common"
cd %~dp0/Server/moon/Lua/_Common
xcopy /Y ".\*.lua.bytes" ".\*.lua"
ren "*.lua.lua" "*.lua"
pause
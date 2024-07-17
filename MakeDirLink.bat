@echo off
echo CurrentDir: %~dp0
mklink /d "%~dp0/Assets/Resources/@Lua/_Common" "%~dp0/Common/Lua/_Common"
mklink /d "%~dp0/Server/moon/Lua/_Common" "%~dp0/Common/Lua/_Common"
cd %~dp0/Server/moon/Lua/_Common
xcopy /Y ".\*.lua.bytes" ".\*.lua"
ren "*.lua" "*."

mklink /d "%~dp0/Assets/Resources/@Lua/_NetMsg" "%~dp0/Common/Lua/_NetMsg"
mklink /d "%~dp0/Server/moon/Lua/_NetMsg" "%~dp0/Common/Lua/_NetMsg"
cd %~dp0/Server/moon/Lua/_NetMsg
xcopy /Y ".\*.lua.bytes" ".\*.lua"
ren "*.lua" "*."
pause
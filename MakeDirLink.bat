@echo off
echo CurrentDir: %~dp0
mklink /d "%~dp0/Assets/Resources/@Lua/_Common" "%~dp0/Common/Lua/_Common"
mklink /d "%~dp0/Server/moon/Lua/_Common" "%~dp0/Common/Lua/_Common"
mklink /d "%~dp0/Assets/Resources/@Lua/_NetMsg" "%~dp0/Common/Lua/_NetMsg"
mklink /d "%~dp0/Server/moon/Lua/_NetMsg" "%~dp0/Common/Lua/_NetMsg"
mklink /d "%~dp0/Server/DS" "%~dp0/outPath/DS"
mklink /d "%~dp0/Library/PackageCache/com.unity.netcode.gameobjects" "%~dp0/backup/com.unity.netcode.gameobjects"
mklink /d "%~dp0/outPath/Proj/Library/PackageCache/com.unity.netcode.gameobjects" "%~dp0/backup/com.unity.netcode.gameobjects"

cd %~dp0/Server/moon/Lua/_Common
del ".\*.lua"
xcopy /Y ".\*.lua.bytes" ".\*.lua"
ren "*.lua" "*."

cd %~dp0/Server/moon/Lua/_NetMsg
del ".\*.lua"
xcopy /Y ".\*.lua.bytes" ".\*.lua"
ren "*.lua" "*."
pause
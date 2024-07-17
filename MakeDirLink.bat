@echo off
echo CurrentDir: %CD%
mklink /d "%CD%/Assets/Resources/@Lua/_Common" "%CD%/Common/Lua/_Common"
pause
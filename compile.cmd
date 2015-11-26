@echo off

:: Check for Python 
py --version >NUL
if errorlevel 1 goto errorNoPython

:: Run buildscript with Python
title Compiling Gamemode

echo Removing UTF8BOM...
py -3 "tools/removeUTF8BOM.py"
echo.
echo Compiling Code...
py -3 "tools/buildscript.py"

if errorlevel 1 (
	pause
)
goto EXIT

:errorNoPython
cls
echo Python is not installed!
pause >NUL

:EXIT
exit
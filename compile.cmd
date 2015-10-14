@echo off

:: Check for Python 
py --version >NUL
if errorlevel 1 goto errorNoPython

:: Run buildscript with Python
title Compiling Gamemode
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
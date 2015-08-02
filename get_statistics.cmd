@echo off

:: Check for Python 
py --version >NUL
if errorlevel 1 goto errorNoPython

:: Run buildscript with Python
title 
py -3 "tools/statistics.py"
goto EXIT

:errorNoPython
cls
echo Python is not installed!
pause >NUL

:EXIT
exit
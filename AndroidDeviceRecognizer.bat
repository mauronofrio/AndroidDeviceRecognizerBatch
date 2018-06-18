@echo off
title Device Recognizer
fastboot devices
for /f "delims=" %%a in ('fastboot devices ') do set s=%%a
echo %s% > result
find "fastboot" result||goto check2
del result
echo Device regognized in fastboot mode
pause & exit

:check2
del result
goto adb
pause & exit

:adb
adb devices
for /f "delims=" %%a in ('adb devices ') do set s=%%a
echo %s% > result
find "attached" result||goto checkadb
del result
echo No device detected
pause & exit

:checkadb
del result
for /f "tokens=1, 2 delims=		" %%a in ("%s%") do set id=%%a&set important=%%b
if %important%==unauthorized goto unauth
if %important%==recovery goto recovery
if %important%==sideload goto sideload
if %important%==offline goto offline
echo Adb device detected
pause & exit

:unauth
echo adb device unauthorized
pause & exit

:recovery
echo device in recovery mode
pause & exit

:sideload
echo device in sideload mode
pause & exit

:offline
echo device offline, unplug and replug it
pause & exit

@echo off
if exist "%1" (
	set /a GetFileSize=%~z1
)
goto :EOF

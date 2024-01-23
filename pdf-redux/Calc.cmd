@echo off
set scale_=1
set Calc_R=

for /l %%i in (1,1,%1) do set /a scale_*=10
set /a "Calc_R=!scale_!*%2"
set /a Calc_R1=!Calc_R!/!scale_!
set /a Calc_R2=!Calc_R!-!Calc_R1!*!scale_!
set Calc_R=!Calc_R1!.!Calc_R2!
goto :EOF

:: PDF-REDUX V 0.1.1
:: Redutor de arquivos PDF.
:: Desenvolvido por Filipe Sizilio
:: O objetivo do script � apenas otimizar a tarefa de redu��o do tamanho de arquivos pdf, utilizado o Ghostscript.
:: Ghostscript/GhostPCL/GhostXPS/GhostPDF/GhostPDL are Copyright 2001-2016 Artifex Software, Inc.
::
:: D�vidas e informa��es: filipesizilio@gmail.com
::
:: Notas da vers�o:
:: Criado menu de op��es

@echo off
set "gs=C:\Program Files\gs\gs9.20\bin\gswin64c.exe"
:home
cls
echo.
echo Selecione o metodo de compressao:
echo =================================
echo.
echo 1 Screen
echo 2 eBook *recomendado*
echo 3 Printer
echo 4 PrePress
echo 5 Mais informacoes
echo 6 Sair
echo.

set /p opt=Escolha um numero [1..6]: 

if "%opt%"=="1" goto screen
if "%opt%"=="2" goto ebook
if "%opt%"=="3" goto printer
if "%opt%"=="4" goto prepress
if "%opt%"=="5" goto inform
if "%opt%"=="6" exit
:: Opcoes ocultas (Develop Mode)
if "%opt%"=="7" set metodo=1
if "%opt%"=="A" goto ALL
goto home

:screen
cls
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH -sOutputFile=%~n1_screen.pdf %1
echo.
echo Compressao concluida:
echo.
echo Nome do arquivo original: "%~nx1"
echo Nome do novo arquivo: "%~n1_screen.pdf"
pause
exit

:ebook
cls
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -sOutputFile=%~n1_ebook.pdf %1
echo.
echo Compressao concluida:
echo.
echo Nome do arquivo original: "%~nx1"
echo Nome do novo arquivo: "%~n1_ebook.pdf"
pause
exit

:printer
cls
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/printer -dNOPAUSE -dBATCH -sOutputFile=%~n1_printer.pdf %1
echo.
echo Compressao concluida:
echo.
echo Nome do arquivo original: "%~nx1"
echo Nome do novo arquivo: "%~n1_printer.pdf"
pause
exit

:prepress
cls
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/prepress -dNOPAUSE -dBATCH -sOutputFile=%~n1_prepress.pdf %1
echo.
echo Compressao concluida:
echo.
echo Nome do arquivo original: "%~nx1"
echo Nome do novo arquivo: "%~n1_prepress.pdf"
pause
exit

:inform
cls
echo.
echo Mais informa��es sobre os metodos de compressao:
echo.
echo  /screen � possui a menor resolu��o e, consequentemente, o menor tamanho de arquivo. Ideal para visualiza��o em tela.
echo  /ebook � � um meio termo entre resolu��o e tamanho de arquivo. Deve ser tentado, se a impress�o com o /screen ficar ruim.

echo  /printer � pr�prio para impress�o, mas o tamanho do arquivo resultante � maior.

echo  /prepress � impress�o em alta qualidade, mas o tamanho do arquivo final fica muito grande.

echo.

pause
goto home

:ALL
cls
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH -sOutputFile=%~n1_screen.pdf %1
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -sOutputFile=%~n1_ebook.pdf %1
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/printer -dNOPAUSE -dBATCH -sOutputFile=%~n1_printer.pdf %1
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/prepress -dNOPAUSE -dBATCH -sOutputFile=%~n1_prepress.pdf %1
cls
echo.
echo Compressao concluida:
echo.
echo Nome do arquivo original: "%~nx1"
echo Nome do novo arquivo: "%~n1_screen.pdf"
echo Nome do novo arquivo: "%~n1_ebook.pdf"
echo Nome do novo arquivo: "%~n1_printer.pdf"
echo Nome do novo arquivo: "%~n1_prepress.pdf"
pause
exit
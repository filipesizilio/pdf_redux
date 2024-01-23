:: PDF-REDUX - V 0.1.2
:: Redutor de arquivos PDF.
:: Desenvolvido por Filipe Sizilio
:: O objetivo do script é apenas otimizar a tarefa de redução do tamanho de arquivos pdf, utilizado o Ghostscript.
:: Ghostscript/GhostPCL/GhostXPS/GhostPDF/GhostPDL are Copyright 2001-2016 Artifex Software, Inc.
::
:: Dúvidas e informações: filipesizilio@gmail.com
::
:: Notas da versão:
:: Otimização do código
:: Melhorias no menu de opções
:: Codificação de acentuação em UTF-8
:: Adicionada opção para apagar arquivo original após a compressão

@echo off
setlocal EnableExtensions
chcp 65001
set "gs=C:\Program Files\gs\gs9.20\bin\gswin64c.exe"
set "conv=0"
:home
cls
echo.
echo Selecione o método de compressão:
echo =================================
echo.
echo 1 Screen
echo 2 eBook (mais recomendado)
echo 3 Printer
echo 4 PrePress
echo 5 Mais informações
echo 6 Sair
echo.

set /p opt=Escolha uma opção [1..6]: 

if "%opt%"=="1" set "metodo=screen"
if "%opt%"=="2" set "metodo=ebook"
if "%opt%"=="3" set "metodo=printer"
if "%opt%"=="4" set "metodo=prepress"
if "%opt%"=="5" goto :inform
if "%opt%"=="6" exit

:: Opcoes ocultas (Develop Mode)
if /I "%opt%" EQU "A" goto :all

if "%opt%"=="7" goto :confirm

cls
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/"%metodo%" -dNOPAUSE -dBATCH -sOutputFile="%~n1_"%metodo%".pdf" %1
echo.
echo Compressão concluída:
echo.
echo Nome do arquivo original: "%~nx1"
echo Nome do novo arquivo: "%~n1_"%metodo%".pdf"
echo.
set /a "conv=1"
goto confirm

:inform
cls
echo.
echo Mais informações sobre os metodos de compressao:
echo ================================================
echo.
echo  /screen   – possui a menor resolução e, consequentemente, 
echo              o menor tamanho de arquivo. Ideal para visualização em tela.
echo.
echo  /ebook    – é um meio termo entre resolução e tamanho de arquivo.
echo              Deve ser tentado, se a impressão com o /screen ficar ruim.

echo.
echo  /printer  – próprio para impressão, mas o tamanho do arquivo resultante 
echo              é maior.

echo.
echo  /prepress – impressão em alta qualidade, mas o tamanho do arquivo final
echo              fica muito grande.

echo.
echo.
echo.

echo Voltar para Menu
pause
goto home

:all
cls
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH -sOutputFile="%~n1_screen.pdf" %1
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -sOutputFile="%~n1_ebook.pdf" %1
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/printer -dNOPAUSE -dBATCH -sOutputFile="%~n1_printer.pdf" %1
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/prepress -dNOPAUSE -dBATCH -sOutputFile="%~n1_prepress.pdf" %1
cls
echo.
echo Compressão concluída:
echo.
echo Nome do arquivo original: "%~nx1"
echo Nome do arquivo 1: "%~n1_screen.pdf"
echo Nome do arquivo 2: "%~n1_ebook.pdf"
echo Nome do arquivo 3: "%~n1_printer.pdf"
echo Nome do arquivo 4: "%~n1_prepress.pdf"
set /a "conv=1"
pause
exit

:confirm
set /p c=Gostaria de apagar o arquivo original [S/N]?
if /I "%c%" EQU "S" goto :apaga
if /I "%c%" EQU "N" goto :home

:apaga
cls
echo.
echo Nome do arquivo que será apagado: "%~nx1"
echo.
echo ATENÇÂO: Esta opção não tem volta!
echo Não será possível recuperar o arquivo.
echo.
set /p d=Tem certeza que deseja prosseguir [S/N]?
if /I "%d%" EQU "S" (
	if %conv%==1 (
		del %1
		cls
		echo.
		echo Arquivo original "%~nx1" foi apagado!
		echo.
		pause
		exit
	) else if %conv%==0 (
		echo Exclusão não permitida!
		echo Você ainda não criou um novo arquivo.
		echo Escolha um método de compressão no menu principal.
		echo.
		pause
		goto :home
	)
)
if /I "%d%" EQU "N" goto :home
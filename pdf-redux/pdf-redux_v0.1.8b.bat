::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: PDF-REDUX - Versão 0.1.8 Beta                                                                        ::
:: Redutor de arquivos PDF.                                                                             ::
:: Desenvolvido por Filipe Sizilio - em 13/02/2017.                                                     ::
::                                                                                                      ::
:: O objetivo do script é apenas otimizar a tarefa de redução do tamanho de arquivos pdf,               ::
:: utilizado o Ghostscript.                                                                             ::
::                                                                                                      ::
:: Ghostscript/GhostPCL/GhostXPS/GhostPDF/GhostPDL/GSView are                                           ::
:: Copyright 2001-2016 Artifex Software, Inc.                                                           ::
::                                                                                                      ::
:: Dúvidas e informações: filipesizilio@gmail.com                                                       ::
::                                                                                                      ::
:: Notas da versão:                                                                                     ::
:: - Compressão em modo "silencioso" ativado por padrão: -dQUIET                                        ::
:: -                                          											                ::
:: -                                           							                                ::
:: -                                           									                        ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
set errorlevel=0
@setlocal EnableExtensions EnableDelayedExpansion
chcp 65001

set ver=0.1.8b

set localpath=%~dp0
set inifile=%localpath%\default.conf
set gs=%localpath%\bin\gswin32c.exe
set gsview=%localpath%\bin\gsview.exe
set silent=-dQUIET

set filepath=%~dp1
set filetype=%~x1
set filesize=0
set filesize=%filesize:~0,-3%


set convname=0
set convsize=0
set convsize=%convsize:~0,-3%
set conv=0

goto main

:header
set header=PDF-REDUX - %ver%
cls && color f0
echo %header%
echo.
echo.

goto :EOF

:main
if exist "%1" (
	if /I "%filetype%" EQU ".pdf" (
		goto home
	) else (
		call :header
		color fc
		echo O arquivo carregado não é um PDF^^!
		echo.
		timeout 5 >nul |echo Aguarde ou pressione qualquer tecla para sair. . .
		exit
	)	 
) else (
	call :header
	color fc
	echo Nenhum arquivo carregado^^!
	echo.
	timeout 5 >nul |echo Aguarde ou pressione qualquer tecla para sair. . .
	exit
)

:home
:: carregar arquivo de configuração
for /f "delims=" %%a in ('call %localpath%\ini.cmd %inifile% DefaultOption Metodo') do (
    set metodo=%%a
)
for /f "delims=" %%a in ('call %localpath%\ini.cmd %inifile% Settings Wait') do (
    set wait=%%a
)

call :header
choice /n /c dm /cs /d d /t %wait% /m "Iniando a compressão no metodo padrão. Pressione M para mais opções."
if errorlevel 2 goto menu
if errorlevel 1 goto default

:menu
set errorlevel=0
call :header
echo Selecione o método de compressão:
echo =================================
echo.
echo [1] Screen
echo [2] eBook (mais recomendado)
echo [3] Printer
echo [4] PrePress
echo [5] Converter para preto e branco (comprime como ebook)
echo [a] Todos acima (escolher depois o melhor resultado)
echo.
echo [i] Mais informações sobre os métodos
echo [s] Sobre o script
echo.
echo [x] Sair
echo.
choice /n /c 12345aisx /cs /d x /t 60 /m "Escolha uma opção: "

if errorlevel 1 set metodo=screen
if errorlevel 2 set metodo=ebook
if errorlevel 3 set metodo=printer
if errorlevel 4 set metodo=prepress
if errorlevel 5 goto 2bw
if errorlevel 6 goto all
if errorlevel 7 goto inform
if errorlevel 8 goto readme
if errorlevel 9 exit



:default
call :header
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/"%metodo%" -dNOPAUSE -dBATCH %silent% -sOutputFile="%~n1_"%metodo%".pdf" %1
set convname=%~dpn1_%metodo%.pdf
set filesize=%~z1
set /a filesize=(%filesize%/1024)+1
call %localpath%\GetFileSize.cmd "%convname%"
set /a convsize=(%GetFileSize%/1024)+1
echo.
echo Compressão concluída:
echo.
echo Nome do arquivo original...: %~nx1 [%filesize% KB]
echo Nome do novo arquivo.......: %~n1_%metodo%.pdf [%convsize% KB]
echo Na pasta...................: %~dp1
echo.

set /a "conv+=1"

goto confirm


:2bw
call :header
"%gs%" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH %silent% -sOutputFile="%~n1_pb.pdf" %1
echo.
echo Conversão concluída:
echo.
echo Nome do arquivo original...: "%~nx1"
echo Nome do novo arquivo.......: "%~n1_pb.pdf"
echo Na pasta...................: %~dp1
echo.
set /a "conv+=1"
set /a "convname=%~dpn1_pb.pdf"
goto confirm

:nome
cls
echo Nomes:
echo.
echo Pasta Instalação: %~dp0
echo Nome completo:    %~dpn1.pdf
echo Nome original:    %~nx1
echo convname:         %convname%
echo file:             %1
echo extensão:         %filetype%
echo tamanho original: !filesize! Bytes
echo tamanho original: !filesizeKB! KB

call GetFileSize.cmd "%convname%"
echo tamanho comprimi: %GetFileSize% Bytes


:readme
call :header
type %localpath%\infor.nfo
call :back

:inform
call :header
type %localpath%\metodos.nfo
call :back

:all
call :header
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
call :back

:confirm
echo.
echo O que gostaria de fazer agora?
echo.
set /p c=[V] Ver o arquivo comprimido, [A] Apagar o arquivo original, [M] Voltar para o menu ou [S] Sair?
if /I "%c%" EQU "V" goto :ver
if /I "%c%" EQU "A" goto :apaga
if /I "%c%" EQU "M" goto :menu
if /I "%c%" EQU "S" exit

:ver
"%gsview%" "%convname%"
::start %convname%
goto confirm

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
	if %conv% GEQ 1 (
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
		goto home
	)
)
if /I "%d%" EQU "N" goto home

:back
echo.
echo.
pause>nul | echo Pressione qualquer tecla para voltar. . .
goto :menu
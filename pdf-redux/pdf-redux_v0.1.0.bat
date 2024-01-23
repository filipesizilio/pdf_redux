REM PDF-REDUX V 0.1.1
REM Redutor de arquivos PDF.
REM Desenvolvido por Filipe Sizilio
REM O objetivo do script � apenas otimizar a tarefa de redu��o do tamanho de arquivos pdf, utilizado o Ghostscript.
REM Ghostscript/GhostPCL/GhostXPS/GhostPDF/GhostPDL are Copyright 2001-2016 Artifex Software, Inc.
REM
REM D�vidas e informa��es: filipesizilio@gmail.com

@echo off
REM  /screen � possui a menor resolu��o e, consequentemente, o menor tamanho de arquivo. Ideal para visualiza��o em tela.

REM  /ebook � � um meio termo entre resolu��o e tamanho de arquivo. Deve ser tentado, se a impress�o com o /screen ficar ruim.

REM  /printer � pr�prio para impress�o, mas o tamanho do arquivo resultante � maior.

REM  /prepress � impress�o em alta qualidade, mas o tamanho do arquivo  final fica muito grande.



"C:\Program Files\gs\gs9.20\bin\gswin64c.exe" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -sOutputFile=%~n1_reduz.pdf %1

echo Nome do arquivo original: "%~nx1"
echo Nome do arquivo reduzido: "%~n1_reduz.pdf"
pause

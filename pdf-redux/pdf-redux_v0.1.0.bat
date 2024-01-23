REM PDF-REDUX V 0.1.1
REM Redutor de arquivos PDF.
REM Desenvolvido por Filipe Sizilio
REM O objetivo do script é apenas otimizar a tarefa de redução do tamanho de arquivos pdf, utilizado o Ghostscript.
REM Ghostscript/GhostPCL/GhostXPS/GhostPDF/GhostPDL are Copyright 2001-2016 Artifex Software, Inc.
REM
REM Dúvidas e informações: filipesizilio@gmail.com

@echo off
REM  /screen – possui a menor resolução e, consequentemente, o menor tamanho de arquivo. Ideal para visualização em tela.

REM  /ebook – é um meio termo entre resolução e tamanho de arquivo. Deve ser tentado, se a impressão com o /screen ficar ruim.

REM  /printer – próprio para impressão, mas o tamanho do arquivo resultante é maior.

REM  /prepress – impressão em alta qualidade, mas o tamanho do arquivo  final fica muito grande.



"C:\Program Files\gs\gs9.20\bin\gswin64c.exe" -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -sOutputFile=%~n1_reduz.pdf %1

echo Nome do arquivo original: "%~nx1"
echo Nome do arquivo reduzido: "%~n1_reduz.pdf"
pause

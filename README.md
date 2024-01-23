# PDF Redux
PDF file reducer/compressor based on Ghostscript

For now it is just a script (.bat) that runs on MS Windows to facilitate the conversion and compression of PDF files using Ghostscript.

## Options
- /screen – has the lowest resolution and, consequently, the smallest file size. Ideal for viewing on screen (as the name suggests)

- /ebook – is a compromise between resolution and file size. It should be tried if printing with /screen is bad.

- /printer – suitable for printing, but the resulting file size is larger.

- /prepress – print in high quality, but the final file size is very large.


## Syntax
- C:\Program Files\gs\gs9.20\bin\gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -sOutputFile=new.pdf old.pdf


### Next steps:

- Implement Windows Explorer context menu.
- Implement batch file conversion.
- Implement option to overwrite or rename original files.
- Show compression results as a percentage in relation to the original.
- Convert pdf to image (jpg/png/tif).
-- Convert PDF to PNG
--- gswin32.exe -q -dNOPAUSE -dBATCH -sDEVICE=pngalpha -dPDFFitPage -sOutputFile=output.png -r144 "input.pdf"
- Rotate page (portrait/landscape)

#### I request support for anyone who wants to cooperate by creating a simple graphical interface and installation program.

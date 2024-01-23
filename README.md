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

+ Include ghostscrips binaries (gs, gswin) without installation, including pdf reader.|v 0.1.3
- Implement Windows Explorer context menu.
+ Implement pdf conversion options.|v 0.1.1
+ Check if the file type is pdf. mime-type (application/pdf) and/or extension.|v 0.1.4b
- Implement batch file conversion.
- Implement option to overwrite or rename original files.
x Show compression results as a percentage in relation to the original. (not viable in the DOS SHELL version)
- Implement other functions to handle PDF files:
   - Batch printing of pdf files. (via Windows Explorer context menu)
   - Convert pdf to image (jpg/png/tif).
   - Rotate page (portrait/landscape)
+ Save default configuration in .ini file (with default conversion and timeout).|v 0.1.6a reading .ini, remaining to write.
- Convert PDF to PNG
   - gswin32.exe -q -dNOPAUSE -dBATCH -sDEVICE=pngalpha -dPDFFitPage -sOutputFile=output.png -r144 "input.pdf"

I request support for anyone who wants to cooperate by creating a Create graphical interface and installation program.

# PDF Redux
PDF file reducer/compressor based on Ghostscript

The main idea is to compress PDF documents in the simplest way possible (with just one click on the context menu or drag and drop).
For now it is just a script (.bat) that runs on MS Windows to facilitate the conversion and compression of PDF files using Ghostscript.
Last version: "pdf-redux_v0.1.8b.bat" (beta) of 05/22/2020.

> [!TIP]
> The context menu in Windows Explorer has not been implemented yet, but you can drag and drop your PDF file on top of the .bat file.


## Installation
- Just copy the contents of the "pdf-redux" folder to a desired location on your computer, the Ghostscript binaries are already included.

> [!IMPORTANT]
> If any errors or problems occur, try installing Ghostscript on your computer using the default installer (googles it).
  

## Options
- /screen – has the lowest resolution and, consequently, the smallest file size. Ideal for viewing on screen (as the name suggests)

- /ebook – is a compromise between resolution and file size. It should be tried if printing with /screen is bad.

- /printer – suitable for printing, but the resulting file size is larger.

- /prepress – print in high quality, but the final file size is very large.


## Syntax
- C:\Program Files\gs\gs9.20\bin\gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=[Option] -dNOPAUSE -dBATCH -sOutputFile=newfile.pdf oldfile.pdf


### Next steps:
- [ ] Interface in multilingual version (currently only pt-br), feel free to translate.
- [x] Include ghostscrips binaries (gs, gswin) without installation, including pdf reader.(ver. 0.1.3)
- [ ] Implement Windows Explorer context menu.
- [x] Implement pdf conversion options.(ver. 0.1.1)
- [x] Check if the file type is pdf. mime-type (application/pdf) and/or extension.(ver. 0.1.4b)
- [ ] Implement batch file conversion.
- [ ] Implement option to overwrite or rename original files.
- [ ] Show compression results as a percentage in relation to the original.
- [x] Save default configuration to .ini file. Reading the configurations in the .ini file, but still not writing.(ver. 0.1.6a)
- [ ] Convert pdf to image (jpg/png/tif).
  - Convert PDF to PNG
    - gswin32.exe -q -dNOPAUSE -dBATCH -sDEVICE=pngalpha -dPDFFitPage -sOutputFile=output.png -r144 "input.pdf"
- [ ] Rotate page (portrait/landscape)

> [!NOTE]
> Anyone who wants to collaborate by creating a simple graphical interface and an installation program, feel free to do. Please share later.

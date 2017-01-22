#!/bin/bash

for file in $(ls *.pdf); do
  printf "Will convert file ${file}\n\n"

  name=${file%.*}
  extension=${file##*.}

  gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -sOutputFile=${name}_default.${extension} ${file}
  gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -sOutputFile=${name}_ebook.${extension} ${file}
  gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -sOutputFile=${name}_screen.${extension} ${file}
done

printf "\nConvertions done\n\n"

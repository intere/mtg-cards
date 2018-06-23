#!/bin/bash
#
# The purpose of this script is to convert all of the SVG images (downloaded via the
# fetch-images script), and convert them to PDFs.
#

svgpdf() {
    "/Applications/Inkscape.app/Contents/Resources/bin/Inkscape" "$PWD"/$1 -A="$PWD"/$1.pdf --without-gui
}

if [ -d set_images ] ; then
  cd set_images
fi

for svg in *.svg
do
  svgpdf "${svg}"
done

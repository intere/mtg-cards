#!/bin/bash
#
# The purpose of this script is to grab all of the set images (using scryfall).
# (They come back as SVN images)
#

if [ ! -d set_images ] ; then
  mkdir set_images
fi


for i in $(curl https://api.scryfall.com/sets | jq '.data[].icon_svg_uri'|grep -v 'default.svg'|sed 's/"//g')
do
  image_name=$(basename $(echo $i|sed 's/\?.*//'))
  curl $i > set_images/${image_name}
done

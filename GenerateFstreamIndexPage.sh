#!/bin/sh
# A script for generating web page listing Fstream URLs from TSV
#
# Author: Jaeho Shin <netj@sparcs.org>
# Created: 2010-05-22
set -e

echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
while read -r url name; do
    printf "<li><a href='%s'>%s</a>\n" \
        "fsradio://`echo "$url" | base64`" \
        "$name"
done

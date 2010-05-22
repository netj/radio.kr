#!/bin/sh
# A script for converting TSV to Fstream importable Plist format
#
# Author: Jaeho Shin <netj@sparcs.org>
# Created: 2010-05-22
set -e


echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">'
echo '<plist version="1.0">'
echo '<array>'
sed -E \
    -e 's#\&#\&amp;#g' \
    -e 's#<#\&lt;#g' \
    -e 's#^([^	]+)	(.*)$#<dict><key>name</key><string>\2</string><key>url</key><string>\1</string></dict>#'
echo '</array>'
echo '</plist>'

#!/bin/sh
# A script for generating Fstream preset files from TSV
#
# Author: Jaeho Shin <netj@sparcs.org>
# Created: 2010-05-22
set -e

Host=$1; shift
Base=$1; shift

cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>host</key>
        <string>$Host</string>
        <key>base</key>
        <string>$Host</string>
        <key>genre</key>
        <string>$Base/fstream/categories.txt</string>
        <key>radio</key>
        <string>$Base/fstream/radios.[genre].txt</string>
        <key>search</key>
        <string>$Base/fstream/radios.txt</string>
    </dict>
</plist>
EOF

mkdir -p fstream
cd fstream
rm -f radios.*.txt
printf '<' >categories.txt
{
    printf '<'
    while IFS='	' read -r url group name; do
        gid=`echo "$group" | md5sum | awk '{print $1}'`
        gf=radios.$gid.txt
        if ! [ -e $gf ]; then
            printf '[%s$%s]' "$gid" "$group" >>categories.txt
            printf '<' >$gf
        fi
        printf '[%s$$$%s]' "$group $name" "$url" |
        tee -a $gf
    done
    printf '>'
} >radios.txt
printf '>' >>categories.txt

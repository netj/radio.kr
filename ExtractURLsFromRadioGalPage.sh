#!/bin/sh
# A script for extracting URLs from RadioGal page
# Author: Jaeho Shin <netj@sparcs.org>
# Created: 2010-05-22
set -e

awk '
/^<H2>.*H2>$/ { gsub(/<[^>]+>/, ""); title=$0; subtitle="" }
/^<H3>.*H3>$/ { gsub(/<[^>]+>/, ""); subtitle=$0 }
/<a href="(mms|http):\/\/[^"]+"/ {
    gsub(/<[^>]+>/, "");
    url=$0
    gsub(/[^ ]+$/, "");
    name=$0
    gsub(/^.* /, "", url);
    print url "\t" title "\t" subtitle "\t" name
}
'

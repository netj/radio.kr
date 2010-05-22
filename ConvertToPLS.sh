#!/bin/sh
# A script for converting TSV to PLS format
# See: http://en.wikipedia.org/wiki/PLS_(file_format)
#
# Author: Jaeho Shin <netj@sparcs.org>
# Created: 2010-05-22
set -e

awk '
BEGIN {
    print "[playlist]"
    print "NumberOfEntries='"`wc -l KoreanRadio.tsv`"'"
    print ""
    i=0
}
{
    i++
    print "File"i"="$1
    sub(/^[^ ]+	+/, "")
    print "Title"i"="$0
    print "Length"i"=-1"
    print ""
}
END {
    print ""
    print "Version=2"
}
'

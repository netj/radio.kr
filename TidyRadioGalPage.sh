#!/bin/sh
# A script for tidying up DCinside RadioGal page
# Author: Jaeho Shin <netj@sparcs.org>
# Created: 2010-05-22
set -e

title='전국 라디오 mms 리스트 - 라디오 갤러리'
echo "<title>$title</title>"
echo '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">'
echo "<h1><a href='$url'>$title</a></h1>"
sed -n '/google_ad_section_start/,/google_ad_section_end/p' |
sed -r \
    -e 's#</P><P>#<BR>#g' \
    -e 's#</P>#<BR>&#g' \
    -e 's/<[Bb][Rr]>/<BR>/g' \
    -e 's/\&nbsp;//g' \
    -e "s#target='?_blank'?##g" \
    -e 's#</A>"#"#g' \
    -e 's#([^'\''"])(mms://[^ ]*)#\1<a href="\2">\2</a>#g' \
    -e 's#</A>#</a>#g' \
    -e 's#<A #<a #g' \
    -e 's#<a +href=[^>]+>(<a +href=[^>]+>[^<]+</a>)</a>#\1#g' \
    -e 's#\&lt;/?U\&gt;##g' \
    -e 's#</?FONT[^>]*>##g' \
    -e 's# ?<BR>##g' \
    -e 's#<BR></STRONG>#</STRONG><BR>#g' \
    -e 's#<BR></STRONG>#</STRONG><BR>#g' \
    -e 's:<STRONG># ?([^<]+)</STRONG><BR>:<H2>\1</H2>:g' \
    -e 's#<STRONG>|</STRONG>##g' \
    -e 's#- ([^<]+)<BR>#<H3>\1</H3>#g' \
    -e 's#(<BR>[^<]+)(<a[^>]+>[^<]+</a>[^)]+\)), (<a )#\1\2\1\3#g' \
    -e 's#(<a[^>]+>[^<]+</a>) *([^<]+)<BR>#\2 \1<BR>#g' \
    |
tr '\r' '\n'

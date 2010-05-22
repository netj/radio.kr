# Makefile for maintaining Korean Radio URL library
# Author: Jaeho Shin <netj@sparcs.org>
# Created: 2010-05-22

HOST:=sparcs.org
BASE:=/~netj/koradio

.PHONY: all
all: \
    index.html \
    fstream/preset \
    KoreanRadioURLs.pls \
    KoreanRadioURLs.fstream.html \
    KoreanRadioURLs.fstream.plist \
    #

# index page
index.html: index.markdown
	echo '<meta http-equiv="content-type" content="text/html;charset=utf-8">' >$@
	Markdown.pl >>$@ <$<

# FStream Preset
fstream/preset: KoreanRadioURLs.tsv Makefile
	mkdir -p $(@D)
	./GenerateFstreamPreset.sh >$@ <$< $(HOST) $(BASE)

# How to gather URLs into our table format
KoreanRadioURLs.tsv: Featured.tsv RadioGal.tsv
	cat >$@ $^

# HTML page with FStream fsradio URLs
KoreanRadioURLs.fstream.html: KoreanRadioURLs.tsv
	./GenerateFstreamIndexPage.sh >$@ <$<

# .plist importable from FStream Mac
KoreanRadioURLs.fstream.plist: KoreanRadioURLs.tsv
	./ConvertToFstreamPlist.sh >$@ <$<

# .pls format
KoreanRadioURLs.pls: KoreanRadioURLs.tsv
	./ConvertToPLS.sh >$@ <$<


# How to mine a plenty of URLs from DCinside Radio Gallery
RadioGal.tsv: RadioGal.html
	./ExtractURLsFromRadioGalPage.sh >$@ <$<
RadioGal.html: RadioGal.html.orig
	./TidyRadioGalPage.sh >$@ <$<
RadioGal.html.orig:
	wget -qNO $@ "http://gall.dcinside.com/list.php?id=radio&no=35715&page=1&bbs="

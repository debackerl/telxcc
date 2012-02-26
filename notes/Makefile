# (c) 2011-2012 Petr Kutalek, Forers, s. r. o.: part of telxcc additions
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.

# 64:45 720x576 -> PAL 16:9 1024x576
# 16:15 720x576 -> PAL  4:3  768x576

ifndef W
    PARMP4 = 16:15
    PARMKV = 16/15
    PREVSIZE = 400x300
else
    PARMP4 = 64:45
    PARMKV = 64/45
    PREVSIZE = 400x224
endif
SRCS = $(wildcard *.ts)
all : $(SRCS:.ts=.mkv)

.PHONY : clean
clean :
	-rm *.vob *.aac *.264 *.srt *.jpg

%.vob : %.ts
	ts2vob -v 6000 < $< > $@ 2> /dev/null

%.srt : %.ts
	-telxcc -1 < $< > $@

%.ttxt : %.srt
	mp4box -ttxt $<

%.jpg : %.ts
	ffmpeg -i $< -an -f image2 -ss 00:00:43 -s $(PREVSIZE) -vframes 1 $@ 2> /dev/null
	-jpegoptim --strip-all $@

%.aac : %.vob
	ffmpeg -i $< -vn -f s16le -acodec pcm_s16le -ac 2 -ar 48000 - 2> /dev/null | \
	    faac -w --mpeg-vers 4 -q 75 -R 48000 -B 16 -C 2 -X -o $@ - 2> /dev/null

%.264 : %.vob
	ffmpeg -i $< -an -f yuv4mpegpipe -pix_fmt yuv420p -deinterlace - 2> /dev/null | \
	    x264 --crf 21 --preset slow --tune film --profile main --level 31 --vbv-bufsize 14000 --vbv-maxrate 14000 \
	    --demuxer y4m --keyint 125 --no-interlaced --threads 4 --output $@ - 2> /dev/null

%.mp4 : %.aac %.264 %.srt %.jpg
	mp4box \
	    -add $(@:.mp4=.264):fps=25:par="$(PARMP4)":group=0:lang=cze \
	    -add $(@:.mp4=.aac):group=1:lang=cze \
	    -add $(@:.mp4=.srt):group=2:hdlr="sbtl:tx3g":lang=und \
	    -itags album="$@":tool="`uname -on`":created="`date +%Y`":cover="$(@:.mp4=.jpg)" \
	    -inter 600 -new $@

%.mkv : %.vob %.srt %.jpg
	mkvmerge \
	    --default-language cze --title "DVB-T" \
	    --default-duration 0:25fps --default-duration 1:25fps --aspect-ratio-factor 0:$(PARMKV) $(@:.mkv=.vob) \
	    --default-track 0:0 --sub-charset 0:utf-8 $(@:.mkv=.srt) \
	    --attachment-mime-type image/jpeg --attachment-name cover.jpg --attach-file $(@:.mkv=.jpg) \
	    -o $@

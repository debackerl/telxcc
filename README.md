# telxcc

telxcc is utility extracting teletext Closed Captions from Transport Streams (DVB-T) into SRT text files.

telxcc is 

* tiny and lightweight (few KiBs binary, no lib dependencies)
* multiplatform (Mac, Linux, Windows)
* modern (fully supports UTF-8, conforms to ETSI 300 706 Presentation Level 1.5)
* stable
* high performing (on Macbook with Intel SSD it processes TS files at speed of 210 MiBps, with less than 30 % 1 CPU core utilization, SSD is the bottleneck)
* easy to use

## Build

    $ make ↵

Or maybe you can also copy any *.ts files into current directory and build profiled version (if you know what are you doing):

    $ make profiled ↵

telxcc has no lib dependencies and is easy to build and run on Linux, Mac and Windows.

## Command line params

    $ ./telxcc -h ↵

    telxcc - teletext closed captioning decoder
    (c) Petr Kutalek <petr.kutalek@forers.com>, 2011-2012; Licensed under the GPL.
    Please consider making a Paypal donation to support our free GNU/GPL software: http://fore.rs/donate/telxcc
    Built on Feb 21 2012
    
    Usage: telxcc [-h] | [-p PAGE] [-t TID] [-o OFFSET] [-n] [-1] [-c] [-s SECONDS]
      STDIN       transport stream
      STDOUT      subtitles in SubRip SRT file format (UTF-8 encoded)
      -h          this help text
      -p PAGE     teletext page number carrying closed captioning (default 888)
      -t TID      transport stream PID of teletext data sub-stream (default auto)
      -o OFFSET   subtitles offset in seconds (default 0.0)
      -n          do not print UTF-8 BOM characters at the beginning of output
      -1          produce at least one (dummy) frame
      -c          output colour information in font HTML tags
                  (colours are supported by MPC, MPC HC, VLC, KMPlayer, VSFilter, ffdshow etc.)
      -s SECONDS  skip SECONDS seconds at the beginning of the stream (default 0)

## Usage example

    $ ./telxcc -p 777 < 2012-02-15_1900_WWW_NRK.ts > dagsrevyen.srt ↵
    telxcc - teletext closed captioning decoder
    (c) Petr Kutalek <petr.kutalek@forers.com>, 2011-2012; Licensed under the GPL.
    Please consider making a Paypal donation to support our free GNU/GPL software: http://fore.rs/donate/telxcc
    Built on Feb 21 2012
    
    INFO: No teletext PID specified, first received suitable stream PID is 576 (0x240), not guaranteed
    INFO: Programme Identification Data = "NRK TV              "
    INFO: Universal Time Co-ordinated = Wed Feb 15 19:14:04 2012
    
    INFO: Done (17745 teletext packets processed, 46 SRT frames written)
    
    $ _

## Other notes

There are some notes on my DVB-T capture and processing chains in notes folder. 

* Task are parallelized (even over multiple files processing -- eg. encoding audio from file 1.ts and video from file 2.ts)
* MP4 output files are fully iPhone/iPad (and also Mac OS X) compatible *including* CC(!) and HTTP streaming (iOS >= 5 and (iPhone >= 4 or iPad 2))

## Pricing

telxcc is free GNU/GPL-licensed software. However if you use it, please consider making a [Paypal donation](http://fore.rs/donate/telxcc).

## Support

Any bug reports are very welcome. Unfortunately I am unable to provide you with free support.

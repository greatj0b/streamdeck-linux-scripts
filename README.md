Audio Change (Perl):
===================

Dependencies: 
------------
libdesktop-notify-perl: https://packages.debian.org/sid/perl/libdesktop-notify-perl

Directions:
----------
Find a good string to reference your desired audio device:

pacmd list-sinks | grep -e "index" -e "device.description"

Use a portion (or all) of this string to call the script. Example:

perl audio-change.pl Corsair VOID PRO

NOTE: Parenthesis cannot be used in the arguments

Streamdeck Instructions:
-----------------------
Create a new button

Give it any name or picture you want

Set command to:

/usr/bin/perl /script/location/audio-change.pl Corsair VOID PRO

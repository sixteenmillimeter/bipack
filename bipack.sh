#!/bin/bash

#IMAGE1
A=${1}
#IMAGE2
B=${2}
#MATTE
MATTE=${3}
#OUTPUT FILE
OUTPUT_FILE=${4}

CONTRAST=100
SIZE="1280x720"
RATE=30

time ffmpeg -y -i $A -i $B -i $MATTE \
	-filter_complex "
		color=0x000000:size=$SIZE, format=rgb24[bla];
		[0] format=rgb24 [a];
		[1] format=rgb24 [b];
		[2] format=gray, smartblur=1, eq=contrast=$CONTRAST, format=rgb24 [maska];
		[2] format=gray, smartblur=1, eq=contrast=$CONTRAST, negate, format=rgb24 [maskb];
		[bla][a][maska] maskedmerge, format=rgb24 [pass1];
		[pass1][b][maskb] maskedmerge, format=rgb24
	" \
	-r $RATE \
	-c:v prores_ks \
	-profile:v 3 \
	$OUTPUT_FILE

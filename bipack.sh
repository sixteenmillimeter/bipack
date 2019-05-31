#!/bin/bash

A=${1}
B=${2}
MATTE=${3}
OUTPUT_FILE=${4}

CONTRAST=100
W=1280
H=720
RATE=24

echo "Running bipack on image sources ${A} and ${B} with ${MATTE} as the matte layer..."

time ffmpeg -y -i $A -i $B -i $MATTE \
	-filter_complex "
		color=0x000000:size=${W}x${H}, format=rgb24[bla];
		[0] fps=${RATE},scale=${W}:${H}:force_original_aspect_ratio=decrease,format=rgb24 [a];
		[1] fps=${RATE},scale=${W}:${H}:force_original_aspect_ratio=decrease,format=rgb24 [b];
		[2] fps=${RATE},scale=${W}:${H}:force_original_aspect_ratio=decrease,format=gray, 
			smartblur=1, eq=contrast=$CONTRAST, format=rgb24 [maska];
		[2] fps=${RATE},scale=${W}:${H}:force_original_aspect_ratio=decrease,format=gray, 
			smartblur=1, eq=contrast=$CONTRAST, negate, format=rgb24 [maskb];
		[bla][a][maska] maskedmerge, format=rgb24 [pass1];
		[pass1][b][maskb] maskedmerge, format=rgb24
	" \
	-r $RATE \
	-c:v prores_ks \
	-shortest \
	-profile:v 3 \
	$OUTPUT_FILE

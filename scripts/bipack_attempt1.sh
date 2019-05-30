#!/bin/bash

#IMAGE1
A=${1}
#IMAGE2
B=${2}
#MATTE
MATTE=${3}
#OUTPUT FILE
OUTPUT_FILE=${4}


MATTE1=$(mktemp -u).mov
MATTE2=$(mktemp -u).mov
PASS1=$(mktemp -u).mov
PASS2=$(mktemp -u).mov

# use rawvideo for intermediary tmp files
# -f rawvideo -pixel_format rgb24

echo "Generating mattes from $MATTE..."

time ffmpeg -y -i $MATTE 	-t 10 -vf eq=saturation=0:contrast=100 -c:v prores_ks -profile:v 4 $MATTE1 
time ffmpeg -y -i $MATTE1	-t 10 -vf negate -c:v prores_ks -profile:v 4 $MATTE2

echo "Applying matte to $A..."

time ffmpeg -y -i $A -i $MATTE1 \
	-t 10 \
	-filter_complex '[1]split[m][a];[a][1]alphamerge[keyed];[0][keyed]overlay=eof_action=endall' \
	-c:v prores_ks \
	-profile:v 4 \
	$PASS1

echo "Applying matte to $B..."

time ffmpeg -y -i $B -i $MATTE2 \
	-t 10 \
	-filter_complex '[1]split[m][a];[a][1]alphamerge[keyed];[0][keyed]overlay=eof_action=endall' \
	-c:v prores_ks \
	-profile:v 4 \
	$PASS2

echo "Cleaning up tmp matte files..."
#echo $MATTE1
rm $MATTE1
rm $MATTE2

echo "Combining matted layers together into $OUTPUT_FILE..."

time ffmpeg -y -i $PASS1 -i $PASS2 \
	-t 10 \
	-filter_complex "[0][1]blend=all_mode='darken'" \
	-c:v prores_ks \
	-profile:v 3 \
	$OUTPUT_FILE

echo "Cleaning up temp files..."

rm $PASS1
rm $PASS2
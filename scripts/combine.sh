#!/bin/bash


#IMAGE1
A=${1}
#IMAGE2
B=${2}
OUTPUT_FILE=${3}

#this combines video with the mattes applied
ffmpeg -y -i $A -i $B -filter_complex "[0][1]blend=all_mode='overlay'" -c:v prores_ks -profile:v 3 $OUTPUT_FILE
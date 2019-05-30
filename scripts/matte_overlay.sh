#!/bin/bash

#ffmpeg -ss 00:00:18.300 -i music.mp3 -loop 1 -i bg.mp4 -i ac%d.png -i dust.mp4 -filter_complex "[1:0]scale=1600:ih*1200/iw, crop=1600:900[a];[a][2:0] overlay=0:0[b]; [3:0] scale=1600:ih*1600/iw, crop=1600:900,setsar=1[c]; [b][c] blend=all_mode='overlay':all_opacity=0.2" -shortest -y output.mp4
#-filter_complex "[0][1]blend=all_mode='overlay'"
#ffmpeg -i video -vf "movie='image',alphaextract[a];[in][a]alphamerge" -c:v qtrle output.mov

#-filter_complex "[1:v]alphaextract[alf];[0:v][alf]alphamerge"
#-filter_complex "[0][1]alphamerge,format=yuva420p"

#-filter_complex '[0]split[m][a];[m][a]alphamerge[keyed];[1][keyed]overlay=eof_action=endall'
#The alphamerge filter adds a grayscale version of its 2nd input as the alpha channel to the 1st. 
#The overlay filter does alpha blending of its inputs.
# -> CLOSE!!!!
# was extracting the wrong value!!!


#overlay 		fills in black areas with color, but darkens them
#subtract 		inverts colors
#multiply128 	does opposite of what I want
#darken 		so close, but it desaturates image layer where white is


#IMAGE
A=${1}
#MATTE LAYER
B=${2}
OUTPUT_FILE=${3}

#swap [0]split with [1]split and [m][a]alphamerge with [a][m]alphamerge
ffmpeg -y -i $A -i $B -filter_complex '[1]split[m][a];[a][m]alphamerge[keyed];[0][keyed]overlay=eof_action=endall' $OUTPUT_FILE
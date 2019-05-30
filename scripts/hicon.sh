#!/bin/bash

INPUT_FILE=${1}
OUTPUT_FILE=${2}

#maximum contrast on video
ffmpeg -y -i $INPUT_FILE -vf eq=saturation=0:contrast=100 $OUTPUT_FILE
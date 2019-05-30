#!/bin/bash

INPUT_FILE=${1}
OUTPUT_FILE=${2}

ffmpeg -y -i $INPUT_FILE -vf negate $OUTPUT_FILE
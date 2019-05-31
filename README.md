# bipack

Script for simulating traveling mattes with ffmpeg. 

## Requirements

Uses `ffmpeg` to generate matte files, apply mattes as alpha masks and render final video.

Installation instructions for ffmpeg here: https://github.com/adaptlearning/adapt_authoring/wiki/Installing-FFmpeg

## Usage

`sh bipack.sh A.mp4 B.mp4 matte.mp4 output.mov`

This command will take video `A.mp4` and `B.mp4` as image sources while using `matte.mp4` as a high contrast matte which seperates the two image sources.

![bipack examples](img/example.jpg?raw=true "Examples")
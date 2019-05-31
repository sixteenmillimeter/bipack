# bipack

Script for simulating traveling mattes with ffmpeg. Achieve the effect of bipacked film with high contrast masks with a simple bash script.

[Read more about traveling mattes.](https://en.wikipedia.org/wiki/Matte_(filmmaking)#Bi-pack_process)

## Requirements

Uses `ffmpeg` to generate matte layers, apply mattes as alpha masks and render the final video.

Installation instructions for ffmpeg here: https://github.com/adaptlearning/adapt_authoring/wiki/Installing-FFmpeg

## Usage

`sh bipack.sh A.mp4 B.mp4 matte.mp4 output.mov`

This command will take video `A.mp4` and `B.mp4` as image sources while using `matte.mp4` as a high contrast matte which seperates the two image sources. Any video passed in as the matte layer will be converted to greyscale and have the contrast maxed out, so you should treat your matte layer before putting it into this script.

![bipack examples](img/example.jpg?raw=true "Examples")

## Explaination

This script started as a multi-command experiment that finally got reduced to a single command that leans heavily on ffmpeg's `maskmerge` filter: [Documentation](https://ffmpeg.org/ffmpeg-filters.html#maskedmerge)

Uses 1280x720 resolution and Apple ProRes 422 HQ as the output format, right now but change that easily in the script. 

Videos at different framerates will cause "slippage" between the mattes and the images, so it's best to standardize those before running this script. The default rate is set to 24fps because it's been the lowest common denominator of the videos this was written for, but you should use a consistent framerate with all videos passed into this script.
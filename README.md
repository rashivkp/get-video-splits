# get-vidoe-splits

Download youtube video splits using youtube-dl, ffmpeg and save them as mp4
files. It will interactively ask for download confirmation to repeat the process
with next split.

## Demo

[![asciicast](https://asciinema.org/a/Cut3WWisfloAtAms3ksNPX93D.svg)](https://asciinema.org/a/Cut3WWisfloAtAms3ksNPX93D)

## Requirements

- ffmpeg
- youtube-dl

## Usage
```
    ./get-videos.sh youtube-URL start-at file-name [length]

    # Example
    ./get-videos.sh https://youtu.be/XguBRi4TDNc 00:01:55 vim 00:10
```

- *start-at*: format HH:MM:SS
- *filename*: specify filename without extension
- *length*: format MM:SS, default 05:00 (5 minutes)


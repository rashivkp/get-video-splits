#!/bin/bash

if [ "$#" -lt 3 ]; then
    echo "
    ./get-videos.sh youtube-URL FromTime file-name [length]

    - FromTime: format HH:MM:SS
    - filename: specify filename without extension
    - Length: format MM:SS, default 05:00 (5 minutes)

    Example: ./get-videos.sh https://youtu.be/XguBRi4TDNc 00:01:55 vim 00:10
    "

    exit 1
fi

if [ "$#" == 4 ]; then
    length=$4
else
    length='05:00'
fi

start_at=$2
prefix=$3
i=1

ffmpeg $(youtube-dl -f 18 -g $1 | sed "s/^/-ss $start_at -i /") -t "$length" -c copy "$prefix"_$i.mp4


start_seconds=$(echo $start_at | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
length_seconds=$(echo $length | awk -F: '{ print ($1 * 60) + $2 }')

while :
do
    read -p "Do you want to continue to next split (y/n)" go_next
    if [ $go_next != 'y' ]; then
        break
    fi

    start_seconds=$(($start_seconds + $length_seconds))
    start_at=$(echo "$start_seconds" | awk -F: '{ printf "%.2d:%.2d:%.2d", int($1 / 3600), int(($1 % 3600)/60),  ($1 % 60) }')
    length=$(echo "$length_seconds" | awk -F: '{ printf "%.2d:%.2d:%.2d", int($1 / 3600), int(($1 % 3600)/60),  ($1 % 60) }')
    i=$(($i + 1))
    ffmpeg $(youtube-dl -f 18 -g $1 | sed "s/^/-ss $start_at -i /") -t "$length" -c copy "$prefix"_$i.mp4
done

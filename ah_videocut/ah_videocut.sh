#!/bin/bash

show_help() {                                                                   
echo -e "                                                                       
ah_videocut (ɔ) kmu-net.ch / andihafner.com 2016 GPLv3                     
Version 1.02, added info and syntax help

Simple shell script which cuts unwanted lead-in and lead-out from e.g. TV
recordings WITHOUT REENCODING using the ffmpeg library.

I wrote this because I didn't find an appropriate graphical application to
achieve this under Linux - either they reencoded the material or if not
(option \"copy\"), audio was out of sinc afterwards.

Syntax:

 ah_videocut video_name start_time end_time

 e.g. ah_videocut test.mp4 00:05:13 01:12:33

Available options:

 --help or -h        Shows this help text\n"
}        

#-------------------------------------------------------------------------------

: "
Todo:

 - Let user choose output destination

 - Test mode (just print out the resulted ffmpeg command sequence)
"

#-------------------------------------------------------------------------------

init() {

	input_file=$1
	echo "Input_file: $input_file"

	destination_file="/mnt/lv_md0/$input_file"
	echo "Destination_file: $destination_file"

}

#-------------------------------------------------------------------------------

convert_hms2seconds() {
    seconds="$(echo $hms | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')"
}

#-------------------------------------------------------------------------------

main() {

	hms=$1
	convert_hms2seconds
	start=$seconds
	echo "Start of extraction at: $1"

	hms=$2
	convert_hms2seconds
	end=$seconds
	echo "End of extraction at: $2"

	duration="$(expr $end - $start)"
	echo "Lenght of extraction in seconds: $duration"

	#echo "avconv -ss $start -i $input_file -acodec copy -vcodec copy -t $duration $destination_file"
	avconv -ss $start -i $input_file -acodec copy -vcodec copy -t $duration $destination_file

}

#-------------------------------------------------------------------------------

case "$1" in

	""|"--help"|"-h")    show_help;;

  *)                   init $1
	                     main $2 $3;;	

esac


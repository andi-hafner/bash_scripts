#!/bin/bash
 
# Version 1.01, internally converted to function blocks
 
init() {
 
	input_file=$1
	echo "Input_file: $input_file"

	destination_file="/mnt/lv_md0/$input_file"
	echo "Destination_file: $destination_file"

}
 
 convert_hms2seconds() {
     seconds="$(echo $hms | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')"
 }
 
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

	avconv -ss $start -i $input_file -acodec copy -vcodec copy -t $duration $destination_file

}
 
init $1
main $2 $3

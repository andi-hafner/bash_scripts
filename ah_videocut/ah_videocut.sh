#!/bin/bash

# Version 1.0

input_file=$1
echo "Input_file: $input_file"

destination_file="/mnt/lv_md0/$input_file"
echo "Destination_file: $destination_file"

convert_hms2seconds() {
    seconds="$(echo $hms | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')"
}

hms=$2
convert_hms2seconds
start=$seconds
echo "Start of extraction at: $2"

hms=$3
convert_hms2seconds
end=$seconds
echo "End of extraction at: $3"

duration="$(expr $end - $start)"
echo "Lenght of extraction in seconds: $duration"

avconv -ss $start -i $input_file -acodec copy -vcodec copy -t $duration $destination_file

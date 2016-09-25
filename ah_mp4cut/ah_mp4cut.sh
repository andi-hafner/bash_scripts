#!/bin/bash

show_help() {
echo -e "
ah_download_magazines (ɔ) kmu-net.ch / swalt.org 2016 GPLv3

Simple script which is able to automatically download multiple issues of
magazines from websites if they are named in a enumerating manner.

Available options:

 --help or -h        Show this help text
 --list_files or -l  Show the generated filelist
 --get_files or -g   Download the desired files
 --version or -v     Show version

So the usual workflow is the following:

 - Edit the desired download url inside the script to match your requirements
 - Call the script by the option '--list' to list the generated urls
 - If all is fine, start downloading the files by the option '--get_files'\n"
}

compose_url() {
# Please compose the desired download url between the quotes below 
website_url="https://www.linux-user.de/Downloads/LUCE/${year}/lu-ce_${year}-${tens_digit}${month}.pdf"
}

wget_options=" --no-check-certificate --no-clobber "
cmd_line_option_1=$1

get_file() {
compose_url 
    if [ "$testdrive" == "true" ]
        then
          echo wget $wget_options $website_url;
        else
          wget $wget_options $website_url;
    fi
}

main() {
: "
Please change the values for years and months to fit your needs.
Don't worry about wrong or inexistent file names - in this case
wget just reports not to find the file and goes on to the next one.
"
for year in {2012..2016}
do
    tens_digit="0";
    for month in {1..9}
    do
        get_file
    done

    tens_digit="1";
    for month in {0..2}
    do
        get_file
    done
done
}

case "$cmd_line_option_1" in

  ""|"--help"|"-h")    show_help;;

  "--list_files"|"-l") testdrive="true"
                       main;;            

  "--get_files"|"-g")  main;;
  
  "--version"|"-v")    echo -e  "\nah_download_magazines Version 0.2.12\n";;

  *)                   echo -e "\nUnknown option: \"$cmd_line_option_1\"\n";;

esac


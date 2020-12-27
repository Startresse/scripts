#!/bin/bash

# This script will banirize given shell/bash script into given or default folder.
# It uses shc `sudo apt install shc`.

# NOTE : just learned you could put a .sh script directly in bin so not sure if it's useful
# NOTE 2 : it is useles

if [ -z $1 ]; then
    echo "Please provide a script path"
    exit
fi

if [[ $1 != *.sh ]]; then
    echo "Please provide bash/shell script"
    exit
fi

filename=$( echo $1 | sed 's/.*\///' ) #remove path
binary_name=$( echo $filename | sed 's/\..*//' ) #remove extension
if [ -z ${2+x} ]; then
    binary_path=$PERSONAL_BIN
else
    binary_path=$2
fi

shc -f $1 -o $binary_name
mv $binary_name $binary_path/$binary_name
rm $1.x.c

echo Created binary \'$binary_name\' in \'$binary_path\'
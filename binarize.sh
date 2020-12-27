#!/bin/bash

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
binary_path=$PERSONAL_BIN

shc -f $1 -o $binary_name
mv $binary_name $binary_path/$binary_name
rm $1.x.c

echo Created binary \'$binary_name\' in \'$binary_path\'
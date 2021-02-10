#!/bin/bash

# This script will circulate on all your sound output devices on each call.

# get sinks and current sink
current_sink_index=$(pacmd list-sinks | grep '*' | grep -o '[0-9]*')
sink_index_list=( $(pacmd list-sinks | grep 'index' | grep -o '[0-9]*') )
eval sink_name_list=( $(pacmd list-sinks | grep device.product.name | grep -o '".*"') )

# default behaviour if problem in finding current sink
next_index=0

# find index of next unused sink
for ((i=0;i<${#sink_index_list[@]};i++)) do
    if [ ${sink_index_list[$i]} -eq $current_sink_index ]; then
        next_index=$((($i + 1) % ${#sink_index_list[@]}))
        break
    fi
done

# switch to next unused sink and display name
pacmd set-default-sink ${sink_index_list[$next_index]}
echo Switched to : ${sink_name_list[$next_index]}
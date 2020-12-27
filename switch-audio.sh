#!/bin/bash

# get sinks and current sink
sink_index_list=( $(pacmd list-sinks | grep 'index' | grep -o '[0-9]*') )
sink_name_list=( $(pacmd list-sinks | grep device.product.name | grep -o '".*"' | sed 's/\ //g') )
current_sink_index=$(pacmd list-sinks | grep '*' | grep -o '[0-9]*')

# fond index of next unused sink
next_index=0
for ((i=0;i<${#sink_index_list[@]};i++)) do
    if [ $device_found ]; then
        next_index=$i
        break
    fi

    if [ ${sink_index_list[$i]} -eq $current_sink_index ]; then
        device_found=1
    fi
done

# switch to next unused sink
pacmd set-default-sink ${sink_index_list[$next_index]}
echo Switched to ${sink_name_list[$next_index]}
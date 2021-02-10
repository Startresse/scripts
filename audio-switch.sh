#!/bin/bash

# switch to sink relative to provided argument and displays sink name in console
switch_to_sink()
{
    pacmd set-default-sink ${sink_index_list[$1]}
    echo Switched to : ${sink_name_list[$1]}
}

# get current sink and sinks ID and name, 
current_sink_index=$(pacmd list-sinks | grep '*' | grep -o '[0-9]*')
sink_index_list=( $(pacmd list-sinks | grep 'index' | grep -o '[0-9]*') )
eval sink_name_list=( $(pacmd list-sinks | grep device.product.name | grep -o '".*"') )

# default behaviour if problem in finding current sink
target_sink_index=0

# if provided an argument : will search first sink name that contains
# the substring provided in argument.
# if provided 0 or more that 1 argument, will circulated on list of sinks.
if [ $# -eq 1 ]; then
    index=0
    for i in "${sink_name_list[@]}"; do
        if [[ ${i,,} == *"${1,,}"* ]]; then
            target_sink_index=$index
            break;
        fi
        index=$((index+1));
    done
else
    for ((i=0;i<${#sink_index_list[@]};i++)) do
        if [ ${sink_index_list[$i]} -eq $current_sink_index ]; then
            target_sink_index=$((($i + 1) % ${#sink_index_list[@]}))
            break
        fi
    done
fi

# switch to next unused sink and display name
switch_to_sink target_sink_index 
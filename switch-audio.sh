#!/bin/bash


## switching and display

switch_to_hs()
{
    pacmd set-default-sink 1
    echo "Switched to HEADSET"
}

switch_to_sp()
{
    pacmd set-default-sink 11
    echo "Switched to SPEAKER"
}


## parsing and automation

if [ $# -gt 0 ]
then
    if [ $1 == "h" ] || [ $1 == "head" ] || [ $1 == "headset" ] || [ $1 == 0 ]
    then
        switch_to_hs
    else
        switch_to_sp
    fi
else
    sink_index=$(pacmd list-sinks | grep '*' | grep -o '[0-9]*')

    if [ $sink_index -eq 11 ]
    then
        switch_to_hs
    else
        switch_to_sp
    fi
fi
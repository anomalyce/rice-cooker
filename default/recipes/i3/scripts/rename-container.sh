#!/usr/bin/env bash

parent="${1}"

if [ -n "${parent}" ]; then
    question="Container Title" 
else
    question="Application Title"
fi

answer=$(zenity --title="i3-msg title_format" --text "${question}" --entry)

if [ -n "${answer}" ]; then
    if [ -n "${parent}" ]; then
        i3-msg focus parent, title_format "${answer}", focus child
    else
        i3-msg title_format "${answer}"
    fi
else
    if [ -n "${parent}" ]; then
        i3-msg focus parent, title_format %title, focus child
    else
        i3-msg title_format %title
    fi
fi

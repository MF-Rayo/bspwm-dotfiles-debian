#!/bin/bash

eww_cmd="eww -c $HOME/.config/eww/widgets/calendar/"

if $eww_cmd active-windows | grep -q "date"; then
    $eww_cmd close date
else
    $eww_cmd open date
fi
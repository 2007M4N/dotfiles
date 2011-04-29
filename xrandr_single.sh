#!/bin/bash
################
# Xrandr sript for Profile work
# If an external monitor is connected, diconect it 
 
# External output may be "VGA" or "VGA-0" or "DVI-0" or "TMDS-1"
EXTERNAL_OUTPUT="VGA1"
INTERNAL_OUTPUT="LVDS1"

xrandr |grep $EXTERNAL_OUTPUT | grep " connected "
 if [ $? -eq 0 ]; then
     xrandr --output $EXTERNAL_OUTPUT --auto --off 
 else
         xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
 fi


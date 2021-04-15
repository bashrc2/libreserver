#!/bin/bash

if [ -f "/etc/login.def" ];then

        RESULT=$(sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/login.defs | grep PASS_MIN_DAYS)
        if [ $? -eq 0 ];then
                if [ "$(echo $RESULT | awk '{printf $2}')" -lt "1" ];then
                        exit 1
                fi  
        else
                exit 1
        fi  
else
        exit 1
fi

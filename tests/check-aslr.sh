#!/bin/bash

if [ ! -f /proc/sys/kernel/randomize_va_space ];then
    exit 1
fi

aslr_mode=$(cat /proc/sys/kernel/randomize_va_space)
if [ $aslr_mode -eq 2 ];then
    :
else
    exit 1
fi

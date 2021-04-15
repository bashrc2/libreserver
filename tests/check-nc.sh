#!/bin/bash

if [ -f /bin/nc ];then
    exit 1
fi

if [ -f /usr/bin/nc ];then
    exit 1
fi

if [[ "$(which nc)" ]]; then
    exit 1
fi

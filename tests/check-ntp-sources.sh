#!/bin/bash

if [ -f /etc/ntpsec/ntp.conf ];then
    if [ $(sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/ntpsec/ntp.conf | grep "pool" | wc -l) -eq 0 ]; then
        exit 1
    fi
else
    exit 1
fi

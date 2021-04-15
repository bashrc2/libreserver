#!/bin/bash

if [ -f /usr/sbin/prelink ];then
    /usr/sbin/prelink -ua
    apt-get purge prelink -y
    apt-get autoremove
    exit 1
fi

#!/bin/bash

if [ $(find / -xdev -type d -perm -002 \! -perm -1000 | wc -l) -gt 0 ];then
    find / -xdev -type d -perm -002 \! -perm -1000
    exit 1
fi

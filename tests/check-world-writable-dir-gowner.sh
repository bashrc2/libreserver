#!/bin/bash

COUNT=$(find / -xdev -perm -002 -type d -fstype ext4  -exec ls -lLdg {} \;  | grep -v "/root" | grep -cv "root\|/var/tmp\|/var/lib/php/sessions")

if [ "${COUNT}" -eq 0 ];then
    :
else
    find / -xdev -perm -002 -type d -fstype ext4  -exec ls -lLdg {} \;  | grep -v "/root" | grep -v "root\|/var/tmp\|/var/lib/php/sessions"
    exit 1
fi

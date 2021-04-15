#!/bin/bash

if [ -f "/etc/pam.d/login" ];then
    VFAIL_DELAY=$(($1 * 1000000)) # microseconds

    RESULT=$(sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/pam.d/login | grep 'pam_faildelay.so' | grep -P -o "\bdelay\s*=\s*\d+" | awk -F '=' '{print $2}')
    if [ "$RESULT" ];then
        if [ "$RESULT" -lt "${VFAIL_DELAY}" ];then
	    echo "login delay: $RESULT, minimum is ${VFAIL_DELAY}"
	    sed -i "s|delay=.*|delay=${VFAIL_DELAY}|g" /etc/pam.d/login
            exit 1
        fi
    else
	echo "auth       optional   pam_faildelay.so  delay=${VFAIL_DELAY}" >> /etc/pam.d/login
        exit 1
    fi
else
    exit 1
fi

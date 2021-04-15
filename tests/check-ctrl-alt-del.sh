#!/bin/bash

if [ -L /etc/systemd/system/ctrl-alt-del.target ];then
    ctrl_alt_del=$(ls -l /etc/systemd/system/ctrl-alt-del.target)
    if [[ "$ctrl_alt_del" !=  *'/dev/null' ]]; then
        exit 1
    fi
else
    if [ -f /etc/systemd/system/ctrl-alt-del.target ];then
        exit 1
    fi
fi

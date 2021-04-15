#!/bin/bash

if [ $(dpkg --verify | grep "^..5" | awk '$2 != "c" { print $NF }' | xargs -I XXX bash -c "[ -f \"XXX\" ] && echo \"XXX\"" | grep -v "htoprc\|prosody\|/npm/\|/usr/bin/pip3\|/tor.service\|/usr/bin/node" | wc -l) -gt 0 ];then
	exit 1
fi

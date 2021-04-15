#!/bin/bash

talkFilename=$(which talk)
if [ "$talkFilename" ];then
    if [ -f "$talkFilename" ];then
	apt-get purge talk -y
	apt-get autoremove
	exit 1
    fi
fi

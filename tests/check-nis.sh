#!/bin/bash

nisFilename=$(which ypserv)
if [ "$nisFilename" ];then
    if [ -f "$nisFilename" ];then
	apt-get purge nis -y
	apt-get autoremove
	exit 1
    fi
fi

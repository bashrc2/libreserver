#1/bin/bash

if [ ! -f /etc/cron.daily/tripwire ];then
        exit 1
fi

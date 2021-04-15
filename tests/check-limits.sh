#!/bin/bash
case $1 in
    core-dumps)
        if [ "$(ulimit -c)" -ne 0 ];then
            exit 1
        fi
        ;;
    maxlogins)
        LIMIT_FOUND=0
        while read -r line ; do
            LIMIT_FOUND=$((LIMIT_FOUND+1))
            if [ "$line" -gt 3 ];then
                echo "logins: $line"
                exit 1
            fi
        done < <(grep -P "^\s*\*\s+hard\s+maxlogins\s+\d+\s*$" /etc/security/limits.conf | cut -d' ' -f4)
        if [ "$LIMIT_FOUND" -ne 1 ];then
            echo 'There should only be one login limit'
            grep -P "^\s*\*\s+hard\s+maxlogins\s+\d+\s*$" /etc/security/limits.conf | cut -d' ' -f4
            exit 1
        fi
        ;;
esac

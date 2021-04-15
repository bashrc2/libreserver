#!/bin/bash

if ! ls /var/lib/tripwire/*.twd 1> /dev/null 2>&1; then
    exit 1
fi

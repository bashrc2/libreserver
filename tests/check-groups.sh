#!/bin/bash

if grep '^+:' "/etc/group" -q; then
    exit 1
fi

#!/bin/bash

if grep 'insecure_locks' /etc/exports; then
        exit 1
fi

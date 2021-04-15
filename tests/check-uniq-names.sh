#!/bin/bash

if [ $(pwck -r | sed '/nonexist/d' | sed '/\/home\//d' | sed '/\/run\//d' | sed '/no changes/d' | wc -l ) -ne 0 ];then
        exit 1
fi
exit 0

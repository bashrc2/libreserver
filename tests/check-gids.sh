#!/bin/bash

if [ $(pwck -r | sed '/nonexist/d' | sed '/\/home\//d' | sed '/\/run\//d' | sed '/no changes/d' | grep "no group" | wc -l) -ne 0 ];then
        exit 1
fi

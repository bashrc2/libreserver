#!/bin/bash

passcrypt=$(grep "password" /etc/pam.d/common-password | grep "pam_unix")
if [[ "${passcrypt}" != *' yescrypt' ]]; then
    return 1
fi

#!/bin/bash
#Verify with the key match from https://ftp-master.debian.org/keys.html

#---------------------------------------------------------------------------
#"Debian Archive Automatic Signing Key (13/trixie) <ftpmaster@debian.org>"

TRIXIEARCHIVEKEY="04B5 4C3C DCA7 9751 B16B  C6B5 2256 29DF 75B1 88BD"
EXPECTED=$(echo "${TRIXIEARCHIVEKEY}" | sed 's| ||g')
DEBKEY=$(gpg --show-keys /etc/apt/trusted.gpg.d/debian-archive-trixie-automatic.asc  | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | sed "/pub/d" | head -n1)

if [ "${DEBKEY}" == "${EXPECTED}" ];then
    echo Good
    :
else
    echo bad
    exit 1
fi

#---------------------------------------------------------------------------
#"Debian Security Archive Automatic Signing Key (13/trixie) <ftpmaster@debian.org>"

TRIXIESECURITYARCHIVEKEY="5E04 A1E3 223A 19A2 0706  E20F 9904 613D 4CCE 68C6"
EXPECTED=$(echo "${TRIXIESECURITYARCHIVEKEY}" | sed 's| ||g')
DEBKEY=$(gpg --show-keys /etc/apt/trusted.gpg.d/debian-archive-trixie-security-automatic.asc  | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | sed "/pub/d" | head -n1)
if [ "${DEBKEY}" == "${EXPECTED}" ];then
    echo Good
    :
else
    echo bad
    exit 1
fi


#---------------------------------------------------------------------------
#"Debian Archive Automatic Signing Key (12/bookworm) <ftpmaster@debian.org>"

BOOKWORMARCHIVEKEY="B8B8 0B5B 623E AB6A D877  5C45 B7C5 D7D6 3509 47F8"
EXPECTED=$(echo "${BOOKWORMARCHIVEKEY}" | sed 's| ||g')
DEBKEY=$(gpg --show-keys /etc/apt/trusted.gpg.d/debian-archive-bookworm-automatic.asc | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | sed "/pub/d" | head -n1)

if [ "${DEBKEY}" == "${EXPECTED}" ];then
    echo Good
    :
else
    echo bad
    exit 1
fi

#---------------------------------------------------------------------------
#"Debian Security Archive Automatic Signing Key (12/bookworm) <ftpmaster@debian.org>"

BOOKWORMSECURITYKEY="05AB 9034 0C0C 5E79 7F44  A8C8 254C F3B5 AEC0 A8F0"
EXPECTED=$(echo "${BOOKWORMSECURITYKEY}" | sed 's| ||g')
DEBKEY=$(gpg --show-keys /etc/apt/trusted.gpg.d/debian-archive-bookworm-security-automatic.asc | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | sed "/pub/d" | head -n1)

if [ "${DEBKEY}" == "${EXPECTED}" ];then
    echo Good
    :
else
    echo bad
    exit 1
fi


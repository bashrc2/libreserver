#!/bin/bash
#Verify with the key match from https://ftp-master.debian.org/keys.html

#---------------------------------------------------------------------------
#"Debian Archive Automatic Signing Key (12/bookworm) <ftpmaster@debian.org>"

BOOKWORMARCHIVEKEY="B8B8 0B5B 623E AB6A D877 5C45 B7C5 D7D6 3509 47F8"
CHECKTMP=$(gpg --with-fingerprint --no-default-keyring --list-keys --keyring /etc/apt/trusted.gpg.d/debian-archive-bookworm-automatic.gpg | grep -B 1 "Debian Archive Automatic Signing Key (12/bookworm) <ftpmaster@debian.org>" | head -n1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

echo "test 1"

if [ "$CHECKTMP" == "$BOOKWORMARCHIVEKEY" ];then
    echo Good
    :
else
    echo bad
    exit 1
fi

#---------------------------------------------------------------------------
#"Debian Security Archive Automatic Signing Key (12/bookworm) <ftpmaster@debian.org>"

BOOKWORMSECURITYKEY="05AB 9034 0C0C 5E79 7F44 A8C8 254C F3B5 AEC0 A8F0"
CHECKTMP=$(gpg --with-fingerprint --no-default-keyring --list-keys --keyring /etc/apt/trusted.gpg.d/debian-archive-bookworm-security-automatic.gpg | grep -B 1 "Debian Security Archive Automatic Signing Key (12/bookworm) <ftpmaster@debian.org>" | head -n1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

echo "test 2"

if [ "$CHECKTMP" == "$BOOKWORMSECURITYKEY" ];then
    echo Good
    :
else
    echo bad
    exit 1
fi

#---------------------------------------------------------------------------
#"Debian Archive Automatic Signing Key (11/bullseye) <ftpmaster@debian.org>"

BULLSEYEARCHIVEKEY="1F89 983E 0081 FDE0 18F3  CC96 73A4 F27B 8DD4 7936"
CHECKTMP=$(gpg --with-fingerprint --no-default-keyring --list-keys --keyring /etc/apt/trusted.gpg.d/debian-archive-bullseye-automatic.gpg | grep -B 1 "Debian Archive Automatic Signing Key (11/bullseye) <ftpmaster@debian.org>" | head -n1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

echo "test 3"

if [ "$CHECKTMP" == "$BULLSEYEARCHIVEKEY" ];then
       echo Good
       :
else
       echo bad
       exit 1
fi

#---------------------------------------------------------------------------
#"Debian Security Archive Automatic Signing Key (11/bullseye) <ftpmaster@debian.org>"

BULLSEYESECURITYKEY="AC53 0D52 0F2F 3269 F5E9  8313 A484 4904 4AAD 5C5D"
CHECKTMP=$(gpg --with-fingerprint --no-default-keyring --list-keys --keyring /etc/apt/trusted.gpg.d/debian-archive-bullseye-security-automatic.gpg | grep -B 1 "Debian Security Archive Automatic Signing Key (11/bullseye) <ftpmaster@debian.org>" | head -n1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

echo "test 4"

if [ "$CHECKTMP" == "$BULLSEYESECURITYKEY" ];then
       echo Good
       :
else
       echo bad
       exit 1
fi

#---------------------------------------------------------------------------
#"Debian Stable Release Key (11/bullseye) <debian-release@lists.debian.org>"

BULLSEYESTABLEKEY="A428 5295 FC7B 1A81 6000  62A9 605C 66F0 0D6C 9793"
CHECKTMP=$(gpg --with-fingerprint --no-default-keyring --list-keys --keyring /etc/apt/trusted.gpg.d/debian-archive-bullseye-stable.gpg | grep -B 1 "Debian Stable Release Key (11/bullseye) <debian-release@lists.debian.org>" | head -n1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

echo "test 5"

if [ "$CHECKTMP" == "$BULLSEYESTABLEKEY" ];then
       echo Good
       :
else
       echo bad
       exit 1
fi


#---------------------------------------------------------------------------
#"Debian Archive Automatic Signing Key (10/buster) <ftpmaster@debian.org>"

BUSTERARCHIVEKEY="80D1 5823 B7FD 1561 F9F7  BCDD DC30 D7C2 3CBB ABEE"
CHECKTMP=$(gpg --with-fingerprint --no-default-keyring --list-keys --keyring /etc/apt/trusted.gpg.d/debian-archive-buster-automatic.gpg | grep -B 1 "Debian Archive Automatic Signing Key (10/buster) <ftpmaster@debian.org>" | head -n1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

echo "test 6"

if [ "$CHECKTMP" == "$BUSTERARCHIVEKEY" ];then
       echo Good
       :
else
       echo bad
       exit 1
fi

#---------------------------------------------------------------------------
#"Debian Security Archive Automatic Signing Key (10/buster) <ftpmaster@debian.org>"

BUSTERSECURITYKEY="5E61 B217 265D A980 7A23  C5FF 4DFA B270 CAA9 6DFA"
CHECKTMP=$(gpg --with-fingerprint --no-default-keyring --list-keys --keyring /etc/apt/trusted.gpg.d/debian-archive-buster-security-automatic.gpg | grep -B 1 "Debian Security Archive Automatic Signing Key (10/buster) <ftpmaster@debian.org>" | head -n1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

echo "test 7"

if [ "$CHECKTMP" == "$BUSTERSECURITYKEY" ];then
       echo Good
       :
else
       echo bad
       exit 1
fi

#---------------------------------------------------------------------------
#"Debian Stable Release Key (10/buster) <debian-release@lists.debian.org>"

BUSTERSTABLEKEY="6D33 866E DD8F FA41 C014  3AED DCC9 EFBF 77E1 1517"
CHECKTMP=$(gpg --with-fingerprint --no-default-keyring --list-keys --keyring /etc/apt/trusted.gpg.d/debian-archive-buster-stable.gpg | grep -B 1 "Debian Stable Release Key (10/buster) <debian-release@lists.debian.org>" | head -n1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

echo "test 8"

if [ "$CHECKTMP" == "$BUSTERSTABLEKEY" ];then
       echo Good
       :
else
       echo bad
       exit 1
fi

#---------------------------------------------------------------------------
#"Debian Archive Automatic Signing Key (9/stretch) <ftpmaster@debian.org>"

STRETCHARCHIVEKEY="E1CF 20DD FFE4 B89E 8026  58F1 E0B1 1894 F66A EC98"
CHECKTMP=$(gpg --with-fingerprint --no-default-keyring --list-keys --keyring /etc/apt/trusted.gpg.d/debian-archive-stretch-automatic.gpg | grep -B 1 "Debian Archive Automatic Signing Key (9/stretch) <ftpmaster@debian.org>" | head -n1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

echo "test 9"

if [ "$CHECKTMP" == "$STRETCHARCHIVEKEY" ];then
       echo Good
       :
else
       echo bad
       exit 1
fi

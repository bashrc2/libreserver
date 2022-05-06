#!/bin/bash

case $1 in
        atd)
                if service --status-all | grep "+.*atd";then
                        exit 1
                fi
        ;;
        avahi-daemon)
                if service --status-all | grep "+.*avahi-daemon";then
                        exit 1
                fi
        ;;
        xinetd)
                if service --status-all | grep "+.*xinetd";then
                        exit 1
                fi
        ;;
        telnetd)
                if sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/inetd.conf | grep telnet;then
                        exit 1
                fi
        ;;
        rshd)
                if sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/inetd.conf | grep rshd;then
                        exit 1
                fi
        ;;
        rexecd)
                if sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/inetd.conf | grep rexecd;then
                        exit 1
                fi
        ;;
        rlogind)
                if sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/inetd.conf | grep rlogind;then
                        exit 1
                fi
        ;;
        nis)
                if service --status-all | grep "+.*\ nis$";then
                        exit 1
                fi
        ;;
        tftpd)
                if sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/inetd.conf | grep tftpd;then
                        exit 1
                fi
        ;;
        cron)
                if ! service --status-all | grep "+.*cron";then
                        exit 1
                fi
        ;;
        ntp)
                if ! service --status-all | grep "+.*ntp";then
                        exit 1
                fi
        ;;
        postfix)
                if ! service --status-all | grep "+.*postfix";then
                        exit 1
                fi
        ;;
        x11-common)
                if service --status-all | grep "+.*x11-common";then
                        exit 1
                fi
        ;;
        bluetooth)
            if service --status-all | grep "+.*bluetooth";then
                /usr/sbin/rmmod -f bnep
                /usr/sbin/rmmod -f bluetooth
                if [ -f /etc/default/bluetooth ]; then
                    if grep -q "BLUETOOTH_ENABLED=" /etc/default/bluetooth; then
                        sed -i 's|BLUETOOTH_ENABLED=.*|BLUETOOTH_ENABLED=0|g' /etc/default/bluetooth
                    else
                        echo "BLUETOOTH_ENABLED=0" >> /etc/default/bluetooth
                    fi
                fi
                if ! grep -q 'blacklist bnep' /etc/modprobe.d/bluetooth.conf; then
                    echo 'blacklist bnep' >> /etc/modprobe.d/bluetooth.conf
                fi
                if ! grep -q 'blacklist btusb' /etc/modprobe.d/bluetooth.conf; then
                    echo 'blacklist btusb' >> /etc/modprobe.d/bluetooth.conf
                fi
                if ! grep -q 'blacklist bluetooth' /etc/modprobe.d/bluetooth.conf; then
                    echo 'blacklist bluetooth' >> /etc/modprobe.d/bluetooth.conf
                fi
                exit 1
            fi
        ;;
        autofs)
                if service --status-all | grep "+.*autofs";then
                        exit 1
                fi
        ;;
esac

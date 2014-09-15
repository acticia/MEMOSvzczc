#!/bin/bash
# ONE LINER CALL :
# wget --no-check-certificate https://raw.githubusercontent.com/acticia/MEMOS/master/patchv0.1.a.sh; chmod u+x patchv0.1.a.sh ; ./patchv0.1.a.sh
/usr/bin/clear
/usr/bin/touch /var/log/acticia/patch/common/patchv0.1.a.log
/usr/bin/touch /var/log/acticia/patch/common/patchv0.1.a.err
lg=/var/log/acticia/patch/common/patchv0.1.a.log
er=/var/log/acticia/patch/common/patchv0.1.a.err
# RENEW SOURCE LIST
/bin/echo deb http://192.168.0.199:9999/debian wheezy main contrib non-free > /etc/apt/sources.list
/bin/echo deb http://192.168.0.199:9999/debian wheezy-updates main contrib non-free >> /etc/apt/sources.list
/bin/echo deb http://192.168.0.199:9999/security wheezy/updates main contrib non-free >> /etc/apt/sources.list
/usr/bin/apt-get update -y 1>>$lg 2>>$er
/usr/bin/apt-get dist-upgrade -y 1>>$lg 2>>$er
/usr/bin/apt-get autoremove --purge -y 1>>$lg 2>>$er
/usr/bin/clear
cat /var/log/acticia/patch/common/patchv0.1.a.log
echo ========ERR========
cat /var/log/acticia/patch/common/patchv0.1.a.err

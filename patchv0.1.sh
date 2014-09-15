#!/bin/bash
# ONE LINER CALL :
# wget wget --no-check-certificate ;  chmod u+x patchv0.1.sh ;  ./patchv0.1.sh
/usr/bin/clear
/usr/bin/dpkg --configure -a
/bin/mkdir -p /var/log/acticia/patch/common
/usr/bin/touch /var/log/acticia/patch/common/patchv0.1.log
/usr/bin/touch /var/log/acticia/patch/common/patchv0.1.err
lg=/var/log/acticia/patch/common/patchv0.1.log
er=/var/log/acticia/patch/common/patchv0.1.err
# RENEW SOURCE LIST
/bin/echo deb http://http.debian.net/debian wheezy main contrib non-free > /etc/apt/sources.list
/bin/echo deb http://http.debian.net/debian wheezy-updates main contrib non-free >> /etc/apt/sources.list
/bin/echo deb http://security.debian.org/ wheezy/updates main contrib non-free >> /etc/apt/sources.list
/usr/bin/apt-get update -y 1>>$lg 2>>$er
/usr/bin/apt-get dist-upgrade -y 1>>$lg 2>>$er
/usr/bin/apt-get autoremove --purge -y 1>>$lg 2>>$er
/usr/bin/apt-get install -y cron-apt heirloom-mailx ssh 1>>$lg 2>>$er


#PREPARE BASE AND COMMON SYSTEM 
#PREPARE MAIL
/usr/bin/clear
read -p "Is your server running an internal SMTP and POP/IMAP service ?" yn
    case $yn in
        [Yy]* ) 	exit;;
        [Nn]* ) 	/usr/bin/apt-get install -y exim4 1>>$lg 2>>$er
			/bin/sed -i "s/dc_eximconfig_configtype='local'/dc_eximconfig_configtype='internet'/" /etc/exim4/update-exim4.conf.conf
			/bin/sed -i "s/dc_eximconfig_configtype='local'/dc_eximconfig_configtype='internet'/" /etc/exim4/update-exim4.conf.conf
			/bin/sed -i "s/dc_local_interfaces='127.0.0.1 ; ::1'/dc_local_interfaces='127.0.0.1'/" /etc/exim4/update-exim4.conf.conf
			/bin/sed -i "s/root: useracticia/root : mat.viguier@gmail.com/" /etc/aliases 
			/usr/sbin/update-exim4.conf 1>>$lg 2>>$er
			;;
        * ) echo "Please answer yes or no.";;
    esac
# SEND LOGS
/bin/tar -czf install_log.tar.gz -C / var/log 1>>$lg 2>>$er
/usr/bin/mail -s "$HOSTNAME LOG" -a /root/install_log.tar.gz root < /dev/null
/usr/bin/clear
cat /var/log/acticia/patch/common/patchv0.1.log
echo ========ERR========
cat /var/log/acticia/patch/common/patchv0.1.err

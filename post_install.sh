#!/bin/sh

# get the "alarmserver" package
fetch "https://github.com/LXXero/DSCAlarm/archive/master.zip" -o /usr/local/

# unpack the package to the install location
unzip /usr/local/master.zip 'DSCAlarm-master/alarmserver/*' -o -j -d /usr/local/alarmserver

# remove the package as it no longer needed
rm /usr/local/master.zip

# install requests pip package
yes | pip-2.7 install requests

# create "alarmsrv" user
pw user add alarmsrv -c alarmsrv -u 1055 -d /nonexistent -s /usr/bin/nologin

# make "alarmsrv" the owner of the install location
mkdir /config
chown -R alarmsrv:alarmsrv /usr/local/alarmserver /config
chmod ug+x /usr/local/alarmserver/*.py
chmod 755 /config

# Start the services
chmod u+x /etc/rc.d/alarmserver
sysrc -f /etc/rc.conf alarmserver_enable="YES"
# service alarmserver start

echo "AlarmServer successfully installed" > /root/PLUGIN_INFO
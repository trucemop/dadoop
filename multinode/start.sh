#!/bin/bash

ADDRESS=`ifconfig eth0 | grep "inet addr" | awk '{print $2}' | cut -d":" -f2`
echo address=\"/namenode/${NAMENODE}\" >> /etc/dnsmasq.d/0hosts

service sshd start

service dnsmasq start

serf agent -event-handler=/root/handler.sh &

runuser -l hadoop -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /usr/lib/hadoop/conf start datanode'
runuser -l hadoop -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /usr/lib/hadoop/conf start tasktracker'


while true;do serf join namenode;sleep 12; done &
while true;do serf event add-me "${HOSTNAME} ${ADDRESS}";sleep 10; done &

/bin/sh


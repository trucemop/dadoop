#!/bin/bash

service sshd start

ADDRESS=`ifconfig eth0 | grep "inet addr" | awk '{print $2}' | cut -d":" -f2`
NAME=`hostname`

echo address=\"/${HOSTNAME}/${ADDRESS}\" >> /etc/dnsmasq.d/0hosts

service dnsmasq start

runuser -l hadoop -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /usr/lib/hadoop/conf start datanode'
runuser -l hadoop -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /usr/lib/hadoop/conf start tasktracker'

/bin/sh


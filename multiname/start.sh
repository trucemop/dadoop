#!/bin/bash

service sshd start

service dnsmasq start

runuser -l hadoop -c 'hadoop namenode -format'


runuser -l hadoop -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /usr/lib/hadoop/conf start namenode'
runuser -l hadoop -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /usr/lib/hadoop/conf start datanode'
runuser -l hadoop -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /usr/lib/hadoop/conf start jobtracker'
runuser -l hadoop -c '/usr/lib/hadoop/bin/hadoop-daemon.sh --config /usr/lib/hadoop/conf start tasktracker'

/bin/sh

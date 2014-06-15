#!/bin/bash

service sshd start

service dnsmasq start

runuser -l hadoop -c '/usr/lib/hadoop/bin/hadoop-daemons.sh --config /usr/lib/hadoop/conf start datanode'

runuser -l hadoop -c '/usr/lib/hadoop/bin/start-mapred.sh --config /usr/lib/hadoop/conf'

/bin/sh


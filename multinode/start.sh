#!/bin/bash

service sshd start

runuser -l hadoop -c '/usr/lib/hadoop/bin/hadoop-daemons.sh --config /usr/lib/hadoop/conf start datanode'


/bin/sh


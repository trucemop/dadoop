#!/bin/bash

service sshd start

runuser -l hadoop -c 'hadoop namenode -format'

runuser -l hadoop -c '/usr/lib/hadoop/bin/start-dfs.sh'

runuser -l hadoop -c '/usr/lib/hadoop/bin/start-mapred.sh'

/bin/sh

#!/bin/bash

service sshd start

runuser -l hadoop -c 'hadoop namenode -format'

runuser -l hadoop -c '/usr/lib/hadoop/bin/start-dfs.sh'


while :
do
	sleep 1
done

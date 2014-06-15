#!/bin/bash

CONTAINERS=`docker ps -a | grep -e hadoop-namenode -e hadoop-multinode -e hadoop-singlenode | awk '{print $1}'`

if [[ ! -z `echo $CONTAINERS` ]] ; then
	docker rm -f $CONTAINERS
fi

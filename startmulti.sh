#!/usr/bin/env bash

export WORKING=$(dirname $0)
export HADOOP_USER_NAME=hadoop
export HADOOP_INSTALL=${WORKING}/tmp/hadoop-0.20.2-cdh3u6
export PATH=${HADOOP_INSTALL}/bin:$PATH

if [ `docker images | grep cdh3 | wc -l` -eq "0" ] ; then
	docker build --rm -t "cdh3" ./cdh3/
fi

if [ `docker images | grep hadoop-namenode | wc -l` -eq "0" ] ; then
	docker build --rm -t "hadoop-namenode" ./multiname/
fi

if [ `docker images | grep hadoop-multinode | wc -l` -eq "0" ] ; then
	docker build --rm -t "hadoop-multinode" ./multinode/
fi


if [ ! -d "./tmp" ]; then
	mkdir tmp
	curl http://archive.cloudera.com/cdh/3/hadoop-0.20.2-cdh3u6.tar.gz > ./tmp/hadoop-0.20.2-cdh3u6.tar.gz
	tar -xzvf ./tmp/hadoop-0.20.2-cdh3u6.tar.gz -C ./tmp/
fi

mkdir -p ./tmp/namenode
mkdir -p ./tmp/data0

if [ `docker ps -a | grep namenode | wc -l` -ne "0" ] ; then
	docker rm -f namenode
fi

NAMENODE=`docker run -t -i -d --dns 172.17.0.1 -h namenode --name namenode hadoop-namenode`

docker run -t -i -d --dns 172.17.0.1 -h data0 hadoop-multinode

export ADDRESS=`docker inspect $NAMENODE | grep "IPAddress" | awk '{print $2}' | sed -e 's/\"//g' -e 's/,//g'`

echo ${ADDRESS}

cat ./core-site.xml | sed "s/REPLACEMEWITHIPADDRESS/${ADDRESS}/g" > $HADOOP_INSTALL/conf/core-site.xml

echo "-------------------------"
echo Starting temporary shell.
echo "-------------------------"

bash



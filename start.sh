#!/usr/bin/env bash

export WORKING=$(dirname $0)
export HADOOP_USER_NAME=hadoop
export HADOOP_INSTALL=${WORKING}/tmp/hadoop-0.20.2-cdh3u6
export PATH=${HADOOP_INSTALL}/bin:$PATH

if [ `docker images | grep cdh3 | wc -l` -eq "0" ] ; then
	docker build --rm -t "cdh3" ./cdh3/
fi

if [ `docker images | grep hadoop-singlenode | wc -l` -eq "0" ] ; then
	docker build --rm -t "hadoop-singlenode" ./single/
fi



if ! hash hadoop 2>/dev/null; then
	rm -rf ./tmp
	mkdir tmp
	curl http://archive.cloudera.com/cdh/3/hadoop-0.20.2-cdh3u6.tar.gz > ./tmp/hadoop-0.20.2-cdh3u6.tar.gz
	tar -xzvf ./tmp/hadoop-0.20.2-cdh3u6.tar.gz -C ./tmp/
fi

CONTAINER=`docker run -t -i -d hadoop-singlenode`

export ADDRESS=`docker inspect $CONTAINER | grep "IPAddress" | awk '{print $2}' | sed -e 's/\"//g' -e 's/,//g'`
echo ${ADDRESS}

cat ./core-site.xml | sed "s/REPLACEMEWITHIPADDRESS/${ADDRESS}/g" > $HADOOP_INSTALL/conf/core-site.xml

bash



#!/usr/bin/env bash

export BASE=$(dirname $0)
cd ${BASE}
export WORKING=`pwd -P`
export HADOOP_USER_NAME=hadoop
export HADOOP_INSTALL=${WORKING}/tmp/hadoop-0.20.2-cdh3u6
export PATH=${HADOOP_INSTALL}/bin:$PATH

if [ `docker images | grep cdh3 | wc -l` -eq "0" ] ; then
	docker build --rm -t "cdh3" ${WORKING}/cdh3/
fi

if [ `docker images | grep hadoop-singlenode | wc -l` -eq "0" ] ; then
	docker build --rm -t "hadoop-singlenode" ${WORKING}/single/
fi



if [ ! -d "${WORKING}/tmp" ]; then
	mkdir tmp
	curl http://archive.cloudera.com/cdh/3/hadoop-0.20.2-cdh3u6.tar.gz > ${WORKING}/tmp/hadoop-0.20.2-cdh3u6.tar.gz
	tar -xzvf ${WORKING}/tmp/hadoop-0.20.2-cdh3u6.tar.gz -C ${WORKING}/tmp/
fi

${WORKING}/stop.sh

NODE=`docker run -t -i -d --dns 172.17.0.1 -h node hadoop-singlenode`

export ADDRESS=`docker inspect $NODE | grep "IPAddress" | awk '{print $2}' | sed -e 's/\"//g' -e 's/,//g'`
echo ${ADDRESS}

cat ${WORKING}/core-site.xml | sed "s/REPLACEMEWITHIPADDRESS/${ADDRESS}/g" > $HADOOP_INSTALL/conf/core-site.xml
cat ${WORKING}/mapred-site.xml | sed "s/REPLACEMEWITHIPADDRESS/${ADDRESS}/g" > $HADOOP_INSTALL/conf/mapred-site.xml


echo "-------------------------"
echo Starting temporary shell.
echo "-------------------------"

env PS1="hadoop$" /bin/bash --norc -i



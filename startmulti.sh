#!/usr/bin/env bash

export BASE=$(dirname $0)
cd ${BASE}
export WORKING=`pwd -P`
export HADOOP_USER_NAME=hadoop
export HADOOP_INSTALL=${WORKING}/tmp/hadoop-0.20.2-cdh3u6
export PATH=${HADOOP_INSTALL}/bin:$PATH
export NUM_NODES=`if [[ -z "$1" ]];then echo 1;else echo $1;fi`

if [ `docker images | grep cdh3 | wc -l` -eq "0" ] ; then
	docker build --rm -t "cdh3" ${WORKING}/cdh3/
fi

if [ `docker images | grep hadoop-namenode | wc -l` -eq "0" ] ; then
	docker build --rm -t "hadoop-namenode" ${WORKING}/multiname/
fi

if [ `docker images | grep hadoop-multinode | wc -l` -eq "0" ] ; then
	docker build --rm -t "hadoop-multinode" ${WORKING}/multinode/
fi


if [ ! -d "${WORKING}/tmp" ]; then
	mkdir ${WORKING}/tmp
	curl http://archive.cloudera.com/cdh/3/hadoop-0.20.2-cdh3u6.tar.gz > ${WORKING}/tmp/hadoop-0.20.2-cdh3u6.tar.gz
	tar -xzvf ${WORKING}/tmp/hadoop-0.20.2-cdh3u6.tar.gz -C ${WORKING}/tmp/
fi

${WORKING}/stop.sh

if [ ! -f "${WORKING}/multiname/key" ] || [ ! -f "${WORKING}/multiname/key.pub" ] ; then
        rm -f ${WORKING}/multiname/key ${WORKING}/multiname/key.pub
        ssh-keygen -f ${WORKING}/multiname/key -t rsa -N ''
fi


NAMENODE=`docker run -t -i -d --dns 127.0.0.1 -h namenode --name namenode hadoop-namenode`
export ADDRESS=`docker inspect $NAMENODE | grep "IPAddress" | awk '{print $2}' | sed -e 's/\"//g' -e 's/,//g'`

echo ${ADDRESS}

ssh-keygen -R ${ADDRESS}

for NUM in `seq 1 $NUM_NODES`; do
	docker run -t -i -d --dns 127.0.0.1 -e NAMENODE=${ADDRESS} -h data$NUM --link namenode:namenode hadoop-multinode
done




cat ${WORKING}/core-site.xml | sed "s/REPLACEMEWITHIPADDRESS/${ADDRESS}/g" > $HADOOP_INSTALL/conf/core-site.xml
cat ${WORKING}/mapred-site.xml | sed "s/REPLACEMEWITHIPADDRESS/${ADDRESS}/g" > $HADOOP_INSTALL/conf/mapred-site.xml


echo "-------------------------"
echo Starting temporary shell.
echo "-------------------------"

env PS1="hadoop$" /bin/bash --norc -i


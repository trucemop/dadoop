FROM cdh3

ADD . /root/

RUN chmod 755 /root/*

RUN chown root:root /root/*

RUN mv -f /root/start.sh /usr/local/bin/start.sh
RUN mv -f /root/multi-core-site.xml /etc/alternatives/hadoop-0.20-conf/core-site.xml
RUN mv -f /root/multi-hdfs-site.xml /etc/alternatives/hadoop-0.20-conf/hdfs-site.xml
RUN mv -f /root/multi-mapred-site.xml /etc/alternatives/hadoop-0.20-conf/mapred-site.xml

EXPOSE 50070 50030 50075 50060 9000 9001

CMD start.sh

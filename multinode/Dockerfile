FROM cdh3

ADD . /root/

RUN chmod 755 /root/*

RUN chown root:root /root/*

RUN mv -f /root/start.sh /usr/local/bin/start.sh
RUN mv -f /root/multi-core-site.xml /etc/alternatives/hadoop-0.20-conf/core-site.xml
RUN mv -f /root/multi-hdfs-site.xml /etc/alternatives/hadoop-0.20-conf/hdfs-site.xml
RUN mv -f /root/multi-mapred-site.xml /etc/alternatives/hadoop-0.20-conf/mapred-site.xml

EXPOSE 50070
EXPOSE 50030
EXPOSE 50075
EXPOSE 50060
EXPOSE 9000

CMD start.sh

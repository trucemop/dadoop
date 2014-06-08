FROM cdh3

ADD . /root/

RUN chmod 755 /root/*

RUN chown root:root /root/*

RUN mv -f /root/start.sh /usr/local/bin/start.sh
RUN mv -f /root/single-core-site.xml /etc/alternatives/hadoop-0.20-conf/core-site.xml
RUN mv -f /root/single-hdfs-site.xml /etc/alternatives/hadoop-0.20-conf/hdfs-site.xml
RUN mv -f /root/single-mapred-site.xml /etc/alternatives/hadoop-0.20-conf/mapred-site.xml

CMD start.sh

FROM cdh3

RUN yum install dnsmasq -y
RUN echo 'address="/namenode/172.17.0.2"' >> /etc/dnsmasq.d/0hosts
RUN echo 'user=root' >> /etc/dnsmasq.conf
RUN echo 'listen-address=127.0.0.1' >> /etc/dnsmasq.conf
RUN echo 'resolv-file=/etc/resolv.dnsmasq.conf' >> /etc/dnsmasq.conf
RUN echo 'conf-dir=/etc/dnsmasq.d' >> /etc/dnsmasq.conf
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.dnsmasq.conf
RUN echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf

ADD . /root/

RUN chmod 755 /root/*

RUN chown root:root /root/*

RUN mv -f /root/start.sh /usr/local/bin/start.sh
RUN mv -f /root/multi-core-site.xml /etc/alternatives/hadoop-0.20-conf/core-site.xml
RUN mv -f /root/multi-hdfs-site.xml /etc/alternatives/hadoop-0.20-conf/hdfs-site.xml
RUN mv -f /root/multi-mapred-site.xml /etc/alternatives/hadoop-0.20-conf/mapred-site.xml

EXPOSE 50070 50030 50075 50060 9000 9001 8020 50010 50020 50090

CMD start.sh

FROM cdh3

RUN echo 'user=root' >> /etc/dnsmasq.conf
RUN echo 'listen-address=127.0.0.1' >> /etc/dnsmasq.conf
RUN echo 'resolv-file=/etc/resolv.dnsmasq.conf' >> /etc/dnsmasq.conf
RUN echo 'conf-dir=/etc/dnsmasq.d' >> /etc/dnsmasq.conf
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.dnsmasq.conf
RUN echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

#serf things
RUN wget -P /root/ https://dl.bintray.com/mitchellh/serf/0.6.1_linux_amd64.zip
RUN unzip /root/0.6.1_linux_amd64.zip -d /usr/local/bin/

ADD key.pub /home/hadoop/.ssh/
RUN cat /home/hadoop/.ssh/key.pub >> /home/hadoop/.ssh/authorized_keys
RUN chown -R hadoop /home/hadoop/.ssh
RUN chmod 600 /home/hadoop/.ssh/authorized_keys
RUN chmod 644 /home/hadoop/.ssh/key.pub

ADD . /root/

RUN chmod 755 /root/*

RUN chown root:root /root/*

RUN mv -f /root/start.sh /usr/local/bin/start.sh
RUN mv -f /root/multi-core-site.xml /etc/alternatives/hadoop-0.20-conf/core-site.xml
RUN mv -f /root/multi-hdfs-site.xml /etc/alternatives/hadoop-0.20-conf/hdfs-site.xml
RUN mv -f /root/multi-mapred-site.xml /etc/alternatives/hadoop-0.20-conf/mapred-site.xml

EXPOSE 50070 50030 50075 50060 9000 9001 8020 50010 50020 50090 7946 7373

CMD start.sh

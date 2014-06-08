FROM cent-hadoop

RUN adduser -g hadoop -s /bin/bash -d /home/hadoop -m hadoop

RUN runuser -l hadoop -c 'mkdir /home/hadoop/.ssh'

RUN chmod 700 /home/hadoop/.ssh


RUN cp /.bashrc /home/hadoop/

RUN echo 'hadoop:password' |chpasswd

#RUN echo "#includedir /etc/sudoers.d" >> /etc/sudoers 

#RUN mkdir /etc/sudoers.d 

#RUN echo "hadoop ALL=(ALL) NOPASSWD:ALL" \ > /etc/sudoers.d/50_stack_sh

RUN ssh-keygen -f /home/hadoop/.ssh/id_rsa -t rsa -N ''

RUN echo StrictHostKeyChecking=no >> /home/hadoop/.ssh/config

RUN cat /home/hadoop/.ssh/*.pub >> /home/hadoop/.ssh/authorized_keys

RUN chown -R hadoop:hadoop /home/hadoop/.ssh

ADD . /root/

RUN chmod 755 /root/*

RUN chown root:root /root/*

RUN mv -f /root/start.sh /usr/local/bin/start.sh
RUN mv -f /root/single-core-site.xml /etc/alternatives/hadoop-0.20-conf/core-site.xml
RUN mv -f /root/single-hdfs-site.xml /etc/alternatives/hadoop-0.20-conf/hdfs-site.xml
RUN mv -f /root/single-mapred-site.xml /etc/alternatives/hadoop-0.20-conf/mapred-site.xml

EXPOSE 50070
EXPOSE 50030

CMD start.sh

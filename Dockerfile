FROM centos

RUN yum install -y curl

RUN yum install -y openssh-server.x86_64

RUN yum install -y openssh-clients.x86_64

RUN mkdir /var/run/sshd

RUN echo 'root:password' |chpasswd

EXPOSE 22

RUN curl http://archive.cloudera.com/redhat/6/x86_64/cdh/cdh3-repository-1.0-1.noarch.rpm > /root/cdh3-repository-1.0-1.noarch.rpm

RUN chmod 755 /root/cdh3-repository-1.0-1.noarch.rpm

RUN yum --nogpgcheck localinstall /root/cdh3-repository-1.0-1.noarch.rpm -y

#RUN yum install hadoop-0.20.noarch -y

#RUN yum install java-1.6.0-openjdk.x86_64 -y

RUN echo "export JAVA_HOME=/usr/lib/jvm/jre-1.6.0-openjdk.x86_64/" >> ~/.bashrc

#RUN yum install hadoop-0.20-namenode.noarch -y

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key

RUN ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''

CMD ["/usr/sbin/sshd", "-D"]




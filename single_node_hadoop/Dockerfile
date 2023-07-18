FROM ubuntu:20.04

USER root

# hadoop 版本
ENV HADOOP_VERSION 3.3.1


RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
# 添加阿里云源
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-get update 
RUN apt-get clean 
RUN apt-get autoremove -y 
RUN apt upgrade -y

# 安装软件
RUN apt-get install -y openjdk-8-jre openjdk-8-jdk openssh-server vim 

# ssh 设置无密码
COPY configs/hosts /etc/hosts
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
RUN ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys
EXPOSE 22



# 创建放hadoop的目录
RUN mkdir -p /hadoop

# 获取hadoop
RUN wget http://mirrors.aliyun.com/apache/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -P /hadoop/
RUN tar -xzf /hadoop/hadoop-$HADOOP_VERSION.tar.gz -C /hadoop/
RUN mv /hadoop/hadoop-$HADOOP_VERSION /hadoop/hadoop
RUN rm -rf /hadoop/hadoop-$HADOOP_VERSION*

# 设置环境变量
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME /hadoop/hadoop
ENV HADOOP_CONF_DIR $HADOOP_HOME/etc/hadoop
ENV PATH $JAVA_HOME/bin:$PATH
ENV PATH $HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH



# 修改 hadoop-env.sh
RUN echo "export JAVA_HOME=$JAVA_HOME" >> /hadoop/hadoop/etc/hadoop/hadoop-env.sh
RUN echo "export HADOOP_HOME=$HADOOP_HOME" >> /hadoop/hadoop/etc/hadoop/hadoop-env.sh
RUN echo "export HADOOP_CONF_DIR=$HADOOP_CONF_DIR" >> /hadoop/hadoop/etc/hadoop/hadoop-env.sh
# root 可以启动
RUN echo "export HDFS_NAMENODE_USER=root" >> /hadoop/hadoop/etc/hadoop/hadoop-env.sh
RUN echo "export HDFS_DATANODE_USER=root" >> /hadoop/hadoop/etc/hadoop/hadoop-env.sh
RUN echo "export HDFS_DATANODE_SECURE_USER=HDFD" >> /hadoop/hadoop/etc/hadoop/hadoop-env.sh
RUN echo "export HDFS_SECONDARYNAMENODE_USER=root" >> /hadoop/hadoop/etc/hadoop/hadoop-env.sh
# 输出到控制台
RUN echo 'export HADOOP_NAMENODE_OPTS="-Dhadoop.log.dir=/dev/stdout"'  >> /hadoop/hadoop/etc/hadoop/hadoop-env.sh
RUN echo 'export HADOOP_DATANODE_OPTS="-Dhadoop.log.dir=/dev/stdout"' >> /hadoop/hadoop/etc/hadoop/hadoop-env.sh
# create folders for nodes
RUN mkdir -p /hadoop/data/nameNode /hadoop/data/dataNode /hadoop/data/nameNodeSecondary /hadoop/data/tmp
RUN mkdir -p /hadoop/hadoop/logs
COPY configs/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
COPY configs/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
COPY configs/workers $HADOOP_HOME/etc/hadoop/workers

EXPOSE 4040
EXPOSE 8088  
EXPOSE 50070
EXPOSE 8080
EXPOSE 18080
EXPOSE 8082
EXPOSE 22

# 格式化
RUN  ./$HADOOP_HOME/bin/hdfs namenode -format

RUN iptables -A INPUT -i lo -p tcp --dport 22 -j ACCEPT

CMD sshd -D && ./$HADOOP_HOME/sbin/start-dfs.sh

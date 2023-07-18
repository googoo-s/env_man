FROM googoo-s/hadoop_cluster_spark

USER root

ENV HIVE_VERSION 2.3.9

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

# get sources
RUN apt-get install -y libpostgresql-jdbc-java
RUN wget http://mirrors.aliyun.com/apache/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz -P /home/hadoop/
RUN tar -xzf /home/hadoop/apache-hive-$HIVE_VERSION-bin.tar.gz -C /home/hadoop/
RUN mv /home/hadoop/apache-hive-$HIVE_VERSION-bin /home/hadoop/hive
RUN rm -rf /home/hadoop/apache-hive-$HIVE_VERSION*

# set environment variables
ENV HIVE_HOME /home/hadoop/hive
ENV PATH $HIVE_HOME/bin:$PATH

RUN cp /usr/share/java/postgresql-jdbc4.jar /home/hadoop/hive/lib/
COPY configs/hive-site.xml $HIVE_HOME/conf/hive-site.xml
RUN echo "export HADOOP_HOME=/home/hadoop/hadoop" >> /home/hadoop/hive/bin/hive-config.sh
RUN mkdir -p $HIVE_HOME/hcatalog/var/log
RUN mkdir -p $HIVE_HOME/var/log
RUN chown hadoop -R /home/hadoop/hive
RUN export LANGUAGE=en_US.UTF-8

FROM googoo-s/hadoop_cluster_hive

USER root

ENV HBASE_VERSION 2.4.17

# HBASE
# get sources
RUN wget http://mirrors.aliyun.com/apache/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz -P /home/hadoop/
RUN tar -xzf /home/hadoop/hbase-$HBASE_VERSION-bin.tar.gz -C /home/hadoop/
RUN mv /home/hadoop/hbase-$HBASE_VERSION /home/hadoop/hbase
RUN rm -rf /home/hadoop/hbase-$HBASE_VERSION-bin.tar.gz*

# set environment variables
ENV  JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV  HBASE_HOME /home/hadoop/hbase
ENV  PATH $PATH:$HBASE_HOME/bin

# set hbase-env.sh
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $HBASE_HOME/conf/hbase-env.sh
RUN echo "export HBASE_HOME=/home/hadoop/hbase" >> $HBASE_HOME/conf/hbase-env.sh
RUN echo "export HBASE_REGIONSERVERS=/home/hadoop/hbase/conf/regionservers" >> $HBASE_HOME/conf/hbase-env.sh
RUN echo "export HBASE_MANAGES_ZK=true" >> $HBASE_HOME/conf/hbase-env.sh
RUN echo "export HBASE_DISABLE_HADOOP_CLASSPATH_LOOKUP=true" >> $HBASE_HOME/conf/hbase-env.sh
COPY configs/hbase-site.xml $HBASE_HOME/conf/hbase-site.xml
COPY configs/hbase-thrift-start.sh $HBASE_HOME/hbase-thrift-start.sh

# copy keys
COPY configs/id_rsa.pub /home/hadoop/.ssh/id_rsa.pub
COPY configs/id_rsa /home/hadoop/.ssh/id_rsa
COPY configs/hbase-keyscan.sh /home/hadoop/
COPY configs/hbase-thrift-start.sh /home/hadoop/
COPY configs/py-base-test-2.py /home/hadoop/hbase
RUN chmod +rx /home/hadoop/hbase-keyscan.sh
RUN chmod 400 /home/hadoop/.ssh/id_rsa
RUN chmod 400 /home/hadoop/.ssh/id_rsa.pub
RUN cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys
RUN chown hadoop -R /home/hadoop/.ssh


# ZooKeeper config
RUN mkdir -p /home/hadoop/zookeeper /home/hadoop/zookeeper/tmp
RUN chown hadoop -R /home/hadoop/zookeeper*

RUN chown hadoop -R /home/hadoop/hbase

RUN mkdir -p /run/sshd
# open port 22
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"] 
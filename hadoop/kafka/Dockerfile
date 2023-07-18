FROM googoo-s/hadoop_cluster_hbase

USER root

ENV KAFKA_VERSION 3.4.1
ENV KAFKA_2_VERSION 2.12


# get Kafka sources
RUN wget  https://mirrors.aliyun.com/apache/kafka/$KAFKA_VERSION/kafka_$KAFKA_2_VERSION-$KAFKA_VERSION.tgz -P /home/hadoop/
RUN tar -xzf /home/hadoop/kafka_$KAFKA_2_VERSION-$KAFKA_VERSION.tgz -C /home/hadoop/ && mv /home/hadoop/kafka_$KAFKA_2_VERSION-$KAFKA_VERSION /home/hadoop/kafka && rm -rf /home/hadoop/kafka_$KAFKA_2_VERSION-$KAFKA_VERSION* && chown hadoop -R /home/hadoop/kafka
ENV KAFKA_HOME=/home/hadoop/kafka
ENV PATH $KAFKA_HOME/bin:$PATH
COPY configs/py-base-test-2.py $HADOOP_HOME/

CMD service ssh start && bash


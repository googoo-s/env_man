FROM googoo-s/hadoop_cluster:hbase

USER root
# get Kafka sources
RUN wget  https://mirrors.aliyun.com/apache/kafka/3.4.1/kafka_2.12-3.4.1.tgz -P /home/hadoop/
RUN tar -xzf /home/hadoop/kafka_2.12-3.4.1.tgz -C /home/hadoop/ && mv /home/hadoop/kafka_2.12-3.4.1 /home/hadoop/kafka && rm -rf /home/hadoop/kafka_2.12-3.4.1* && chown hadoop -R /home/hadoop/kafka
ENV KAFKA_HOME=/home/hadoop/kafka
ENV PATH $KAFKA_HOME/bin:$PATH
ADD configs/py-base-test-2.py $HADOOP_HOME/

CMD service ssh start && bash


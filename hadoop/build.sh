#!/bin/bash

# generate ssh key
echo "Enter your filename"
KEYFILE=configs/id_rsa
if [ -f "$KEYFILE" ]
then
    echo "Key is already available"
else
   echo "Y" | ssh-keygen -t rsa -P "" -f configs/id_rsa
fi

# Hadoop build
docker build -f ./hadoop/Dockerfile . -t googoo-s/hadoop_cluster_hadoop

# Spark
docker build -f ./spark/Dockerfile . -t googoo-s/hadoop_cluster_spark

# PostgreSQL Hive Metastore Server
docker build -f ./postgresql-hms/Dockerfile . -t googoo-s/hadoop_cluster_postgresql-hms

# Hive
docker build -f ./hive/Dockerfile . -t googoo-s/hadoop_cluster_hive

# HBASE
docker build -f ./hbase/Dockerfile . -t googoo-s/hadoop_cluster_hbase

# kafka
docker build -f ./kafka/Dockerfile . -t googoo-s/hadoop_cluster_kafka

# hue
#docker build -f ./hue/Dockerfile . -t googoo-s/hadoop_cluster_hue

# BELOW TOOLS are disabled
# Nifi
#docker build -f ./nifi/Dockerfile . -t googoo-s/hadoop_cluster_nifi






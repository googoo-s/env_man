#!/bin/bash

# generate ssh key
#echo "Y" | ssh-keygen -t rsa -P "" -f configs/id_rsa

# # Hadoop build
# docker build -f ./hadoop/Dockerfile . -t googoo-s/hadoop_cluster:hadoop

# # Spark
# docker build -f ./spark/Dockerfile . -t googoo-s/hadoop_cluster:spark

# # PostgreSQL Hive Metastore Server
# docker build -f ./postgresql-hms/Dockerfile . -t googoo-s/hadoop_cluster:postgresql-hms

# # Hive
# docker build -f ./hive/Dockerfile . -t googoo-s/hadoop_cluster:hive

# HBASE - NEW
docker build -f ./hbase/Dockerfile . -t googoo-s/hadoop_cluster:hbase

# BELOW TOOLS WILL BE DELETED
# Nifi
#docker build -f ./nifi/Dockerfile . -t googoo-s/hadoop_cluster:nifi

# Edge
#docker build -f ./edge/Dockerfile . -t googoo-s/hadoop_cluster:edge

# hue
#docker build -f ./hue/Dockerfile . -t googoo-s/hadoop_cluster:hue

# zeppelin
#docker build -f ./zeppelin/Dockerfile . -t googoo-s/hadoop_cluster:zeppelin


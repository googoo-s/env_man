# HADOOP HBASE HIVE SPARK DOCKER CONTAINERS 
## MacOS(Intel) and Linux tested and it is recommended, also you can deploy via WSL on Windows. 

Thanks to **Aditya Pal** - I forked his original project/repo (https://github.com/googoo-s/dockers). For this setup, considerable changes were done to make it work/integrate, having a development/lab Hadoop platform for testing purposes with udpdated compnents.

This project in the original repo has 1 master, 2 workers, 1 kafka node (with Flume, Sqoop and Kafka !!) , 1 Hue service node, 1 Zeppelin service node and 1 Nifi node.

**PS** -> HBASE was added in the platform. Nifi, Hue and Zeppelin were disabled to consume less resources.

**PS2** : Spark and Hadoop are in the version 3 now. for a next step, it will be recreated this Hadoop Ecosystem platform using docker compose (https://docs.docker.com/compose/). The way of this current version is composing throgh scripts.

**UPDATE** : To have a lighter platform including HBASE service this repo will deploy only Hadoop, Hbase, Zookeeper, Hive, Hive Metastore (PostGresSQL) and Spark only. It is possible to add the other services back, together with Hbase, modifying the script files for build and cluster.

### This platform was validate with MacOs running on Intel Processor and Linux, running all the shell scripts. For Windows, using Docker Desktop, it was not totally tested. But the Batch files are present. Also for Windows you can deploy via WSL, but again, you can encounter some issues. Also for windows, before run the build.bat file you must create or add in configs ssh keys id_rsa and id_rsa.pub. You can run via Windows Subsystem for Linux (WSL) ssh-keygen available in the build.sh (bash script). If you run the on MacOS with M1/M2 - ARM architecture, please change in the Hadoop Dockerfile the java path to arm64.

### Make sure that you build the Dockerfiles for each components in your local environment. Otherwise you will get an older and not tested version from docker hub repo.

## Services

* [Hadoop 3.3.1](http://hadoop.apache.org/docs/r3.3.1/) HDFS in  Distributed (Multi-node) Mode
* [Hive 2.3.9](http://hive.apache.org/) with HiveServer2
* [Spark 3.1.2](https://spark.apache.org/docs/3.1.2/) in SPARK MASTER mode (Spark Scala, and PySpark) - You can trigger a job also as YARN giving more resources (CPU, MEMORY)
* [Hbase 2.4.15](https://hbase.apache.org/)  in Pseudo Distributed Mode on top of HDFS

Also there is available an kafka node to run conde/scripts

> If you have more resources to run the containers, you can run Spark over YARN, as Defalut, Spark is running with Spark Master (1 Master, 3 workers). Just need to change Spark configuration file.

<br />

**NOTE: Please verify that the download links in the Dockerfiles are still active.**

For Hadoop: Choose any Hadoop version > 2.0 from here https://archive.apache.org/dist/hadoop/core/

For Hive: Choose Hive version > 2.0.0 (preferably < 3.0) from here https://archive.apache.org/dist/hive/

For Spark: Choose Spark version > 2.0 from here https://archive.apache.org/dist/spark/

<br />

**Update: Added pyspark support.**

 ... Change to your default python version in spark Dockerfile

<br />

**Instructions for use**

1. Build cluster using **./build.sh**

2. Once all images are built, install/deploye cluster containers with all configurations by **./cluster.sh Install**

3. Verify the containers running by **docker ps -as**. nodemaster, node2, node3, psqlhms and hbase containers should be running.

4. Enter any container this way: **docker exec -u hadoop -it nodemaster /bin/bash**

5. Once all work is done, bring down cluster by **./cluster.sh stop**

6. Once all containers are created/deployed via install and stopped with the previous command, you can restart cluster keeping the state by **./cluster.sh start**

7. Simple instructions to test the cluster after the deployment in the **cluster_simple_test.md**(https://github.com/kennonsr/hadoop_hbase_hive_spark_docker/blob/main/cluster_simple_test.md) file are available.

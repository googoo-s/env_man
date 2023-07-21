# apache/hadoop

## 启动
```
docker-compose up -d
```

## 处理

* 进入集群
```
docker exec -it docker-3_namenode_1 /bash 
```

* 提交任务
```
yarn jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.5.jar pi 10 15
```

* UI
```
http://localhost:9870/ 
http://localhost:8088/
```


## 参考
https://hub.docker.com/r/apache/hadoop
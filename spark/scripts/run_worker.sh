#!/usr/bin/env bash

echo -e "<configuration> \n\
    <property> \n\
        <name>fs.default.name</name> \n\
        <value>hdfs://$1:8020</value> \n\
    </property> \n\
</configuration>" > $HADOOP_HOME/conf/core-site.xml
$HADOOP_HOME/sbin/hadoop-daemon.sh start datanode
$SPARK_HOME/sbin/start-slave.sh spark://$1:7077
$SPARK_HOME/sbin/start-shuffle-service.sh
tail -F $SPARK_HOME/logs/*
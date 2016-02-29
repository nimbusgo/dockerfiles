#!/usr/bin/env bash

echo -e "<configuration> \n\
    <property> \n\
        <name>fs.default.name</name> \n\
        <value>hdfs://$(hostname):8020</value> \n\
    </property> \n\
</configuration>" > $HADOOP_HOME/conf/core-site.xml
$HADOOP_HOME/sbin/hadoop-daemon.sh start namenode
$SPARK_HOME/sbin/start-master.sh $@
$SPARK_HOME/sbin/start-shuffle-service.sh
tail -F $SPARK_HOME/logs/*
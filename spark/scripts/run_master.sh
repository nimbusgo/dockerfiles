#!/usr/bin/env bash

$SPARK_HOME/sbin/start-master.sh $@
$SPARK_HOME/sbin/start-shuffle-service.sh
tail -F $SPARK_HOME/logs/*
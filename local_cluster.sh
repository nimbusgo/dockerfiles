docker network create simple
docker run -p 8080 --net=simple --name=master --hostname=master -idt nimbusgo/spark-hdfs /scripts/run_master.sh
docker run -p 8081 --name=slave1 --hostname=slave1 --net=simple -idt nimbusgo/spark-hdfs /scripts/run_worker.sh master -m 1G
docker run -p 8888 -p 4040 --name=notebook --hostname=notebook --net=simple \
 -e SPARK_OPTS="--properties-file=/confs/default.conf --master=spark://master:7077" -dt nimbusgo/spark-kernel-notebook

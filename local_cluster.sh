docker network create simple
docker run -p 8080 --net=simple --name=master --hostname=master -idt spark /scripts/run_master.sh
docker run -p 8081 --name=slave1 --hostname=slave1 --net=simple -idt spark /scripts/run_worker.sh spark://master:7077 -m 1G
docker run -p 8888 -p 4040 --name=notebook --hostname=notebook --net=simple -dt spark-kernel-notebook

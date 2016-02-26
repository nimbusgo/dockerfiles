FROM nimbusgo/spark
#   Setup

ENV PYTHONPATH $PYTHONPATH:$SPARK_HOME/python/

RUN mkdir /dl \
    && curl -SL https://s3-us-west-2.amazonaws.com/bb-spark/spark-kernel/spark-kernel-0.1.5-SNAPSHOT.tar.gz \
    >> /dl/spark-kernel-0.1.5-SNAPSHOT.tar.gz \
    && tar -xzf /dl/spark-kernel-0.1.5-SNAPSHOT.tar.gz \
    && rm -rf /dl

ADD .ipython /root/.ipython
add confs /confs

ENV SPARK_OPTS "--properties-file=/confs/default.conf"
ENTRYPOINT ["ipython", "notebook", "--ip", "0.0.0.0"]

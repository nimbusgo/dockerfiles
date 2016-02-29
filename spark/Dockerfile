FROM ubuntu:14.04

# Install Java
RUN apt-get install software-properties-common curl -y
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN apt-get install debconf-utils
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
RUN apt-get install -y oracle-java8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0-bin-without-hadoop.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && mv spark-1.6.0-bin-without-hadoop spark
ENV SPARK_HOME /usr/local/spark

# disable ipv6
RUN echo "net.ipv6.conf.all.disable_ipv6 = 1\n\
net.ipv6.conf.default.disable_ipv6 = 1\n\
net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf

# HDP repo
RUN wget http://public-repo-1.hortonworks.com/HDP/ubuntu14/2.x/updates/2.3.4.0/hdp.list -O /etc/apt/sources.list.d/hdp.list
RUN apt-get update

# HDP hadoop libs
RUN apt-get install hadoop hadoop-hdfs libhdfs0 hadoop-yarn hadoop-mapreduce hadoop-client openssl -y --force-yes

# HDP compression libs
RUN apt-get install libsnappy1 libsnappy-dev
RUN apt-get install liblzo2-2 liblzo2-dev hadooplzo -y --force-yes


ENV HADOOP_HOME /usr/hdp/2.3.4.0-3485/hadoop
ENV HADOOP_COMMON_HOME=$HADOOP_HOME \
    HADOOP_HDFS_HOME=$HADOOP_HOME \
    HADOOP_MAPRED_HOME=$HADOOP_HOME \
    HADOOP_YARN_HOME=$HADOOP_HOME \
    HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

ENV SPARK_DIST_CLASSPATH $HADOOP_HOME/conf:$HADOOP_HOME/lib/*:$HADOOP_HOME/.//*:$HADOOP_HOME-hdfs/./:$HADOOP_HOME-hdfs/lib/*:$HADOOP_HOME-hdfs/.//*:$HADOOP_HOME-yarn/lib/*:$HADOOP_HOME-yarn/.//*:$HADOOP_HOME-mapreduce/lib/*:$HADOOP_HOME-mapreduce/.//*

## install anaconda
RUN wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda2-2.4.1-Linux-x86_64.sh
RUN bash Anaconda2-2.4.1-Linux-x86_64.sh -b
ENV PATH $PATH:/root/anaconda2/bin
ENV PYTHONPATH $SPARK_HOME/python
RUN pip install py4j

RUN hadoop namenode -format
ADD spark-defaults.conf $SPARK_HOME/conf/
ADD scripts /scripts
RUN chmod +x /scripts/*
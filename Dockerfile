FROM centos:7
MAINTAINER "yacine" <yacine.2limi@gmail.com>

ENV NEO4J_VERSION 3.0.7
ENV NEO4J_ARCHIVE neo4j-community-$NEO4J_VERSION-unix.tar.gz
ENV NEO4J_ARCHIVE_URL https://neo4j.com/artifact.php?name=$NEO4J_ARCHIVE

RUN yum update -y && yum install -y which wget java-1.8.0-openjdk-headless && yum clean all && wget $NEO4J_ARCHIVE_URL -O $NEO4J_ARCHIVE && mkdir /opt/neo4j && tar xvzf $NEO4J_ARCHIVE -C /opt/neo4j && rm -rf $NEO4J_ARCHIVE && ln -s /opt/neo4j/*neo4j* /opt/neo4j/default && sed -i 's/#dbms.connector.http.address=0.0.0.0:7474/dbms.connector.http.address=0.0.0.0:7474/g' /opt/neo4j/default/conf/neo4j.conf

ENV PATH=$PATH:/opt/neo4j/default/bin

EXPOSE 7474

ENTRYPOINT ["neo4j"]
CMD ["console"]
FROM centos/systemd

MAINTAINER "jiahui Zhu" <jiahui.zhu1503@gmail.com>

RUN yum -y update; yum clean all;

ENV NEO4J_VERSION 3.0.7
ENV NEO4J_ARCHIVE neo4j-community-$NEO4J_VERSION-unix.tar.gz
ENV NEO4J_ARCHIVE_URL https://neo4j.com/artifact.php?name=$NEO4J_ARCHIVE

# UTF-8 locale
RUN localedef -c -f UTF-8 -i en_US en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

# Install NEO4J
RUN \
	yum -y update \
	&& yum -y install \
		which \
		wget \
		ca-certificates \
		java-1.8.0-openjdk-devel \
	&& yum clean all \
	&& wget $NEO4J_ARCHIVE_URL -O $NEO4J_ARCHIVE \
	&& mkdir /opt/neo4j \
	&& tar xvf $NEO4J_ARCHIVE -C /opt/neo4j \
	&& rm -f $NEO4J_ARCHIVE \
	&& ln -s /opt/neo4j/*neo4j* /opt/neo4j/default

# Data volume
VOLUME ["/data"]

# Configuration volume
VOLUME ["/conf"]

# Directories of binaries are added to PATH
ENV PATH=$PATH:/opt/neo4j/default/bin

# The NEO4J daemon starts
COPY entrypoint.sh /
#ENTRYPOINT ["bash", "entrypoint.sh"]
EXPOSE 8886
CMD ["/usr/sbin/init"]
#Base image for elasticsearch

FROM ubuntu:latest
LABEL maintainer="ui3o <ui3o.com@gmail.com>"

EXPOSE 9200
ENV KBN_VERSION="7.10.2"
ENV DEBIAN_FRONTEND=noninteractive

### install core programs
RUN apt-get update
RUN apt-get install -y wget lsof git vim htop curl locales locales-all
### prompt fix
ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

### install elastic
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$KBN_VERSION-amd64.deb
RUN apt-get install -f ./elasticsearch-$KBN_VERSION-amd64.deb -y

RUN sed -i 's/#network.host: 192.168.0.1/network.host: 0.0.0.0/g' /etc/elasticsearch/elasticsearch.yml
RUN sed -i 's/#node.name: node-1/node.name: node-1/g' /etc/elasticsearch/elasticsearch.yml
RUN sed -i 's/#cluster.initial_master_nodes: \["node-1", "node-2"\]/cluster.initial_master_nodes: node-1/g' /etc/elasticsearch/elasticsearch.yml

### create elasticsearch user
RUN mkdir /home/elasticsearch
RUN chown elasticsearch:elasticsearch -R -v /home/elasticsearch/

### set owner elasticsearch user to elasticsearch
RUN chown elasticsearch:elasticsearch -R -v /etc/elasticsearch/
RUN chown elasticsearch:elasticsearch -R -v /usr/share/elasticsearch/

## timezone set
RUN ln -sf /usr/share/zoneinfo/CET /etc/localtime
## default folder set
RUN echo "cd /root" >> ~/.bashrc

USER elasticsearch

ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]

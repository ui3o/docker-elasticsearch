# docker-elasticsearch
Docker image for elasticsearch

# Version

**major.minor.path** version is for **elasticsearch**.

The **build number** for **this project** release. 

# Possible
*  `docker run -d -p 9200:9200 -v elasticdata:/usr/share/elasticsearch/ --name elastic ui3o/docker-elasticsearch:7.10.2.1`
# Linux

* Please set **sysctl -w vm.max_map_count=262144**
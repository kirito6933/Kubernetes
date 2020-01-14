#!/bin/bash
clear
cat /etc/motd
#Script d'installation auto de docker pour centos
echo "Installation Docker"
#Install Clé Docker
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum update && yum install docker-ce docker-ce-cli containerd.io
systemctl start docker

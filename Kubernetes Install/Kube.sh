#!/bin/bash
# Install Docker CE
## Set up the repository:
### Install packages to allow apt to use a repository over HTTPS
clear
cat /etc/motd
echo #### install Prérequis#### 
yum update && yum upgrade -y
yum install curl gnupg2 
yum install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
yum update && yum install -y \
  apt-transport-https ca-certificates curl software-properties-common
Echo STEP 2 Deploiement Docker

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum update
yum install -y kubelet kubeadm kubectl
done

#### Image Developpement V1 ######
FROM debian:latest
LABEL version="0.0.1-alpha"
##
MAINTAINER "ALEXANDRE ARGIVIER <alexandre.argivier@codeo.com"

#############

### ARGUMENTS ###

ARG FORCEAPT="-y"
ARG WWW-ROOT="/var/www/"
ARG php-all="php php-gd php-intl php-ldap php-mysql php-zip php-json php-iamp php-apcu"

###

## Application sécurité et accès ###

RUN apt install ${FORCEAPT} openssh-server
COPY sshd_config /etc/ssh/sshd_config
RUN apt install fail2ban rkhunter ${FORCEAPT}
RUN apt install ${FORCEAPT} gnupg2
##

## Installation de la couche APACHE ##

RUN apt install ${FORCEAPT} apache2 \ 
    apache2-utils

COPY site-available /etc/apache2/site-available

##

#### Installation de la couche PHP 7.x ###

RUN apt install ${FORCEAPT} libapache2-mod-php \
    ${php-all} \ php-fpm

###

## INstallation de la couche git 

RUN apt install -y git

## 

### Installation de la couche Developpement Version 1.0

COPY phpbrew.sh /tmp/php.sh
RUN bash /tmp/php.sh
RUN [[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
CMD cd /root/

COPY nvm.sh /root/nvm.sh
RUN bash /root/nvm.sh

RUN apt install ${FORCEAPT} composer \ 
    phpy-dev \ php-xml \ 
    gcc \ 
#### 
### Conf général de l'image
CMD mkdir /Developpement
WORKDIR /Developpement
ENTRYPOINT service sshd start && /bin/bash

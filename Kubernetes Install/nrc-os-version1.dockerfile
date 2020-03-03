#### Jarvis 1.0 OS ####
FROM debian:latest
label version="0.0.1"
MAINTAINER "Alexandre ARGIVIER <alexandre.argivier@core-network.fr>"

COPY /etc/motd /etc/motd
#####

### Affectation des arguments

ARG www-root="/var/www/html"
ARG APT-FORCE="-y"
ARG php="php php-gd php-intl php-ldap php-mysql php-zip php-json php-iamp php-apcu"

####

### Création de la couche apache2 ###

RUN APT install ${APT-FORCE} apache2 
COPY /root/jarvis.conf /etc/apache2/site-available/jarvis.conf

####

### Ajout de la couche PHP ###
RUN apt install ${APT-FORCE} ${php}

### Mise en place de la couche système 
RUN apt install ${FORCEAPT} unzip \
    php-dev \
    composer \
    python \ 
    python-pip \
    mycli \ 
    openssh-server

# Exposition des ports de Jarvis 

expose 443
expose 10000
expose 80
expose 8080
expose 8022
expose 5000

####

#### Environnement de travail 

COPY /etc/ssh/sshd_config

WORKDIR /home/

ENTRYPOINT service apache2 start && service sshd start
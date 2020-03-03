#### Image Developpement V1 ######
FROM debian:latest
LABEL version="0.0.1-alpha"
##
MAINTAINER "ALEXANDRE ARGIVIER <alexandre.argivier@codeo.com"

#############

### Conf général de l'image
RUN mkdir /Developpement
WORKDIR /Developpement

### ARGUMENTS ###

ARG FORCEAPT="-y"
ARG WWW-ROOT="/var/www/"
ARG php-all="php php-gd php-intl php-ldap php-mysql php-zip php-json php-iamp php-apcu"

###

## Application sécurité et accès ###

RUN apt install ${FORCEAPT} openssh-server curl wget 
COPY sshd_config /etc/ssh/sshd_config
RUN apt install fail2ban rkhunter ${FORCEAPT}
RUN apt install ${FORCEAPT} gnupg2
##

## Installation de la couche APACHE ##

RUN apt install ${FORCEAPT} apache2 \ 
    apache2-utils

RUN service apache2 start
RUN systemctl enable apache2
##

#### Installation de la couche PHP 7.x ###

RUN apt install ${FORCEAPT} libapache2-mod-php \
    ${php-all} \
    php-fpm \ 
    php-pear

###

## Installation de la couche git 

RUN apt install -y git

## 

### Installation de la couche Developpement Version 1.0

### Phase 1 : PHP BREW ###

RUN curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
RUN chmod +x phpbrew.phar
RUN mv phpbrew.phar /usr/local/bin/phpbrew

RUN [[ -e ~/.phpbrew/bashrc ]] 
RUN source ~/.phpbrew/bashrc

## Phase deux NVM 

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash 
RUN export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

## 
## Phase 3 : Composant de developpement

RUN apt install ${FORCEAPT} composer \ 
    phpy-dev \ php-xml \ 
    gcc
#### 

## Service Dameon
RUN systemctl enable apache2
RUN systemctl enable sshd
RUN systemctl start apache2
RUN systemctl start sshd

##

### Exposition des ports 

EXPOSE 80
EXPOSE 443
EXPOSE 22
EXPOSE 3306
EXPOSE 3307
EXPOSE 8080
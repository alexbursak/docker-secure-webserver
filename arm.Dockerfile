FROM arm32v7/ubuntu:18.04

RUN apt-get update

RUN echo "Europe/London" > /etc/timezone
RUN apt-get install tzdata

# Install PHP7.4
RUN apt -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install php7.4 -y && \
    apt-get install php7.4-xml -y && \
    apt-get install php7.4-mbstring -y && \
    apt-get install php-mysql -y && \
    apt-get install php7.4-zip -y && \
    apt-get install php7.4-fpm -y

# Install other
RUN apt-get install apache2 -y
RUN    apt-get install ufw -y
RUN    apt-get install systemd -y
RUN    apt-get install curl -y
#RUN    apt-get install composer -y
RUN    apt-get install vim -y
RUN    apt-get install tor -y
RUN    apt-get install wget -y

COPY ./composer-setup.sh /composer-setup.sh
RUN bash /composer-setup.sh

RUN mv /composer.phar /usr/bin/composer

# Install node and npm
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt install nodejs -y

# Apache2
COPY ./apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod proxy_fcgi
RUN a2enmod rewrite
RUN mkdir -p /var/www/project

ENV TZ Europe/London

EXPOSE 80
EXPOSE 443

COPY ./toriptables3.py /toriptables3.py
RUN chmod 755 /toriptables3.py

COPY ./check_my_ip.sh /check_my_ip.sh
RUN chmod 755 /check_my_ip.sh

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh

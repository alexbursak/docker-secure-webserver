FROM ubuntu:18.04

RUN apt-get update

RUN echo "Europe/London" > /etc/timezone && \
    apt-get install tzdata

ENV TZ Europe/London

# Install PHP7.4
RUN apt -y install software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install php7.4 -y && \
    apt-get install php7.4-xml -y && \
    apt-get install php7.4-mbstring -y && \
    apt-get install php7.4-mysql -y && \
    apt-get install php7.4-zip -y && \
    apt-get install php7.4-fpm -y

# Install Composer
COPY ./composer-setup.sh /composer-setup.sh
RUN bash /composer-setup.sh && \
    mv /composer.phar /usr/bin/composer

# Install utils
RUN apt-get install apache2 -y && \
    apt-get install ufw -y && \
    apt-get install systemd -y && \
    apt-get install curl -y && \
    apt-get install vim -y && \
    apt-get install tor -y && \
    apt-get install wget -y

# Install node and npm
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt install nodejs -y

# Configure Apache
COPY ./apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod proxy_fcgi && \
    a2enmod rewrite && \
    mkdir -p /var/www/project

COPY ./toriptables3.py /toriptables3.py
COPY ./check_my_ip.sh /check_my_ip.sh

RUN chmod 755 /toriptables3.py && \
    chmod 755 /check_my_ip.sh

EXPOSE 80
EXPOSE 443

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh

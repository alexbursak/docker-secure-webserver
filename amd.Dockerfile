FROM kalilinux/kali:latest

RUN apt-get update

RUN echo "Europe/London" > /etc/timezone
RUN apt-get install tzdata

# Install PHP7.4
RUN apt-get install php7.4 -y && \
    apt-get install php7.4-xml -y && \
    apt-get install php7.4-mbstring -y && \
    apt-get install php-mysql -y && \
    apt-get install php7.4-zip -y && \
    apt-get install php7.4-fpm -y

# Install other
RUN apt-get install apache2 -y && \
    apt-get install ufw -y && \
    apt-get install systemd -y && \
    apt-get install curl -y && \
    apt-get install composer -y && \
    apt-get install vim -y && \
    apt-get install python2 -y && \
    apt-get install tor -y && \
    apt-get install wget -y

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

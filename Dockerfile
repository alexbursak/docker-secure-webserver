FROM kalilinux/kali:latest

COPY ./toriptables3.py /toriptables3.py
RUN chmod 755 /toriptables3.py

RUN apt-get update

# Install Generic Libs
RUN apt-get install apache2 -y && \
    apt-get install ufw -y && \
    apt-get install systemd -y && \
    apt-get install curl -y && \
    apt-get install composer -y && \
    apt-get install python2 -y && \
    apt-get install tor -y && \
    apt-get install wget -y && \
    apt-get install vim -y

# Install PHP7.4
RUN apt-get install php7.4 -y && \
    apt-get install php7.4-xml -y && \
    apt-get install php-mysql -y && \
    apt-get install php7.4-zip -y

RUN a2enmod rewrite
RUN mkdir -p /var/www/project
RUN service apache2 restart

EXPOSE 80
EXPOSE 443

RUN echo "" >> /etc/apache2/apache2.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY ./check_my_ip.sh /check_my_ip.sh
RUN chmod 755 /check_my_ip.sh

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh

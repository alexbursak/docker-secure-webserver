FROM kalilinux/kali-linux-docker:latest

COPY ./toriptables2.py /toriptables2.py
RUN chmod 755 /toriptables2.py

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

# Install PHP7.3
RUN apt-get install php7.3 -y && \
    apt-get install php7.3-xml -y && \
    apt-get install php-mysql -y && \
    apt-get install php7.3-zip -y

RUN a2enmod rewrite
RUN mkdir -p /var/www/project
RUN service apache2 restart

EXPOSE 80
EXPOSE 443

RUN echo "" >> /etc/apache2/apache2.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh

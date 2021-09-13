#!/bin/bash
#service apache2 restart && tail -f /dev/null
#service apache2 restart && /toriptables3.py -l && /bin/bash

# PHP
service php7.4-fpm start

# Apache2
service apache2 restart

service php7.4-fpm status
service apache2 status
service cron status

/toriptables3.py -l

#exec "$@"
/bin/bash

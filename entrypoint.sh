#!/bin/bash
#service apache2 restart && tail -f /dev/null
service apache2 restart && /toriptables3.py -l && /bin/bash

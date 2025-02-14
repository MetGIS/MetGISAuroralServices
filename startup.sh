#!/bin/bash
cp -r /staticfiles/*   /usr/local/apache2/htdocs/

keyplaceholder="{{apikey}}"

find /usr/local/apache2/htdocs/ -type f -exec sed -i "s/$keyplaceholder/$API_KEY/g" {} +

httpd-foreground
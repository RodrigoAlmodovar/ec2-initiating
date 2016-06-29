#!/bin/bash
echo " server {
        listen   80; ## listen for ipv4; this line is default and implied
        
        root /usr/share/nginx/html/api;
        index 1.html;
        # Make site accessible from http://localhost/
        server_name api.localhost;
}" > /etc/nginx/sites-available/virtualHost.conf
	ln -s /etc/nginx/sites-available/virtualHost.conf /etc/nginx/sites-enabled/virtualHost.conf
	service nginx restart
echo "VirtualHost created and ready to be used!"
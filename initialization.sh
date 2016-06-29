#!/bin/bash

COUNTER=1
function pageContent {

	case $COUNTER in
     1)
        echo "	
			<div>
				This is the site number $COUNTER
			</div> 
			<a href='$(($COUNTER+1)).html'> Next </a>
		"
     ;;
     40)
        echo "	
			<div>
				This is the site number $COUNTER
			</div>
			<a href='$(($COUNTER-1)).html'> Previous </a>
		"
     ;;
     *)
        echo "	
			<div>
				This is the site number $COUNTER
			</div>
			<a href='$(($COUNTER-1)).html'> Previous </a> 
			<a href='$(($COUNTER+1)).html'> Next </a>
		"
     ;;
  esac
}

#Nginx installation
#Añado el repositorio de nginx con su clave para asegurarme de que se instala la versión estable según Nginx
wget nginx.org/keys/nginx_signing.key
#Según lo probado, se guarda en el directorio ubuntu
apt-key add /nginx_signing.key
sed -i "\$a\deb http://nginx.org/packages/ubuntu/ trusty nginx\ndeb-src http://nginx.org/packages/ubuntu/ trusty nginx" /etc/apt/sources.list
apt-get update
apt-get install -y nginx

#chown -R $USER:$USER /var/www ESTO NO HARA FALTA PORQUE SE EJECTARA COMO ROOT TODO
#cat /etc/apache2/envvars | tr 'www-data' '$USER'
sed -i "3i\127.0.0.1\tapi.localhost" /etc/hosts
#Para que funcione desde el api.localhost he de iniciar nginx mediante: /usr/bin/nginx

#Para que sirva las paginas dentro de /html/api/ modifico el /etc/nginx/conf.d/default.conf
sed -i "9c\\\troot   /usr/share/nginx/html/api;" /etc/nginx/conf.d/default.conf

##Prueba para la configuracion del virtualHost
mkdir /etc/nginx/sites-available
mkdir /etc/nginx/sites-enabled
sudo sed -i "32i\    include /etc/nginx/sites-enabled/*;" /etc/nginx/nginx.conf

#VirtualHost creation
echo "server {
        listen   80; ## listen for ipv4; this line is default and implied
        
        root /usr/share/nginx/html/api;
        index 1.html;
        # Make site accessible from http://localhost/
        server_name api.localhost;
}" > /etc/nginx/sites-available/virtualHost.conf
	ln -s /etc/nginx/sites-available/virtualHost.conf /etc/nginx/sites-enabled/virtualHost.conf
	service nginx restart

#Create 40 sites
while [  $COUNTER -lt 41 ]; do
	mkdir -p /usr/share/nginx/html/api 2> /dev/null
	pageContent > /usr/share/nginx/html/api/"$COUNTER".html    	
   	let COUNTER=COUNTER+1 
done

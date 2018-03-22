#!/bin/bash

case $argc in
	3) 
		MYSQL_USER=$1;
		MYSQL_PASSWORD=$2;
		;;
	2)
		MYSQL_USER=$1;
		MYSQL_PASSWORD=wpuser;
		;;
	1)
		MYSQL_USER=wpuser;
		MYSQL_PASSWORD=wpuser;
		;;
esac

mkdir -p wordpress_data/database;
mkdir -p wordpress_data/html;

docker run -e MYSQL_ROOT_PASSWORD=123qwe -e MYSQL_USER=$MYSQL_USER -e MYSQL_PASSWORD=$MYSQL_PASSWORD -e MYSQL_DATABASE=wordpress_db \
					 --volume "./wordpress_data/database:/var/lib/mysql" --name wordpressdb --detach mariadb
docker run --name wordpress --publish 8080:80 --volume "./wordpress_data/html:/var/www/html" --link wordpressdb:mysql --detach wordpress:4.9.3_nginx

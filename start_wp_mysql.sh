#!/bin/bash

case $# in
	2) 
		MYSQL_USER=$1;
		MYSQL_PASSWORD=$2;
		;;
	1)
		MYSQL_USER=$1;
		MYSQL_PASSWORD=wpuser;
		;;
	0)
		MYSQL_USER=wpuser;
		MYSQL_PASSWORD=wpuser;
		echo $#
		echo $MYSQL_USER;
		echo $MYSQL_PASSWORD;
		;;
esac

BASE_PATH=$(pwd);
database="$BASE_PATH/wordpress-data/database";
html="$BASE_PATH/wordpress-data/html";

mkdir -p $database;

docker run -e MYSQL_ROOT_PASSWORD=123qwe -e MYSQL_USER=$MYSQL_USER -e MYSQL_PASSWORD=$MYSQL_PASSWORD -e MYSQL_DATABASE=wordpress_db \
					 --volume $database:/var/lib/mysql --name wordpressdb --detach mariadb

docker run --name wordpress --publish 8080:80 --link wordpressdb:mysql --detach wordpress:4.9.3_nginx

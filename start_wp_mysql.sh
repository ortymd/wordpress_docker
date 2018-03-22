#!/bin/bash

updated=0;

case $# in
	2) 
		MYSQL_USER=$1;
		MYSQL_PASSWORD=$2;
		updated=1;
		;;
	1)
		MYSQL_USER=$1;
		MYSQL_PASSWORD=wpuser;
		updated=1;
		;;
	0)
		MYSQL_USER=wpuser;
		MYSQL_PASSWORD=dbpass;
		;;
esac

pushd image_setup
if ((updated));then

	if -e wp-config.php;then
		rm wp-config.php
	fi

	cp wp-config-template.php wp-config.php
	sed -i s/wpuser/$1/ wp-config.php
	sed -i s/dbpass/$2/ wp-config.php
else
	cp wp-config-template.php wp-config.php
fi
popd

BASE_PATH=$(pwd);
database="$BASE_PATH/wordpress-data/database";
html="$BASE_PATH/wordpress-data/html";

mkdir -p $database;

echo $MYSQL_USER
echo $MYSQL_PASSWORD

docker build --tag wordpress:4.9.3_nginx -f image_setup/Dockerfile image_setup/

docker run -e MYSQL_ROOT_PASSWORD=123qwe -e MYSQL_USER=$MYSQL_USER -e MYSQL_PASSWORD=$MYSQL_PASSWORD -e MYSQL_DATABASE=wordpress_db \
					 --volume $database:/var/lib/mysql --name wordpressdb --detach mariadb

docker run --name wordpress --publish 8080:80 --link wordpressdb:mysql --detach wordpress:4.9.3_nginx

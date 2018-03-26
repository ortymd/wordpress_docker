#!/bin/bash

updated=0;
BASE_PATH=$(pwd);
database="$BASE_PATH/wordpress-data/database";
html="$BASE_PATH/wordpress-data/html";
image_setup="image_setup";
remote_syslog_path="image_setup/remote_syslog_linux_amd64.tar.gz";

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

docker build --tag wordpress:4.9.3_nginx -f $image_setup/Dockerfile_nginx $image_setup

docker run -e MYSQL_ROOT_PASSWORD=123qwe \
	-e MYSQL_USER=$MYSQL_USER \
	-e MYSQL_PASSWORD=$MYSQL_PASSWORD \
	-e MYSQL_DATABASE=wordpress_db \
	--name wordpressdb \
 	--volume $database:/var/lib/mysql \
	--detach mariadb:latest

docker run --name wordpress \
	--publish 8080:80 \
	--link wordpressdb:mysql \
	--detach wordpress:4.9.3_nginx

docker run --restart=always \
	-e LOGSPOUT=ignore \
	--volume /var/run/docker.sock:/var/run/docker.sock \
	--name papertrail \
	--detach gliderlabs/logspout:master  \
	syslog://logs4.papertrailapp.com:44743

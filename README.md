# wordpress_docker
GENERAL
=================
This is a simple setup of Wordpress in a Docker container.
Wordpress runs on nginx, php and MariaDB.

To start service run start_wp_mysql.sh script.
You can provide database username and password to the script.

Usage :
	start_wp_mysql.sh  'wp_db_username' 'wp_db_password'

If no access details are provided, defaults are used.
Namely, 'wpuser' and 'dbpass'.

WORDPRESS SETUP
=================

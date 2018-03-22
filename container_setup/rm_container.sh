#!/bin/bash

docker stop wordpress; 
docker stop wordpressdb; 
docker rm wordpress; 
docker rm wordpressdb; 

docker build --tag wordpress:4.9.3_nginx .;

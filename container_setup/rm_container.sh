#!/bin/bash

docker stop wordpress; 
docker stop wordpressdb; 
docker rm wordpress; 
docker rm wordpressdb; 

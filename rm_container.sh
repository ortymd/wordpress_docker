#!/bin/bash

docker stop wordpress; 
docker stop wordpressdb; 
docker stop dd-agent; 
docker rm wordpress; 
docker rm wordpressdb; 
docker rm dd-agent; 

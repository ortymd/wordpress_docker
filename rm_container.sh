#!/bin/bash

docker stop wordpress; 
docker stop wordpressdb; 
docker stop datadog-agent; 
docker stop papertrail;
docker rm wordpress; 
docker rm wordpressdb; 
docker rm datadog-agent; 
docker rm papertrail;

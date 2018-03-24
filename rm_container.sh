#!/bin/bash

docker stop wordpress; 
docker stop wordpressdb; 
docker stop datadog-agent; 
docker rm wordpress; 
docker rm wordpressdb; 
docker rm datadog-agent; 

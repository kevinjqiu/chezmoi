#! /bin/bash
docker build -t dev-docker.points.com:80/$1:newrelic . && docker push dev-docker.points.com:80/$1:newrelic

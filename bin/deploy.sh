#! /bin/bash
docker run -it --env-file=aws-per.env --dns=192.168.253.2 --dns=192.168.253.3 -e "SSH_USER=buildmgr" -e "SSH_KEY=$(cat ~/.ssh/buildmgr.pem)" -e "IMAGE=dev-docker.points.com:80/$1:newrelic" dev-docker.points.com:80/$1:newrelic deploy

#!/bin/bash

kubectl create -f keys/secret-user-conf.yml
kubectl create -f keys/secret-host-keys.yml
kubectl create -f sftp-deploy.yml
# if using fail2ban then need to skip kub-proxy by using hostPort
# kubectl create -f sftp-service.yml

#rm -rf keys
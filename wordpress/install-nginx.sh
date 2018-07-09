#!/bin/bash
set -e

#create server with terraform 
terraform apply 

#get public ip
ip=`terraform output ip`

#copy ansible playbooks file nginx.yaml
scp -i ~/.ssh/xps.pem nginx.yaml ubuntu@${ip}:~/

#install ansible
ssh -i ~/.ssh/xps.pem ubuntu@${ip} -C "sudo apt-get update && sudo apt-get install -y ansible"

#install nginx and wordpress with ansible
ssh -i ~/.ssh/xps.pem ubuntu@${ip} -C "sudo ansible-playbook nginx.yaml"

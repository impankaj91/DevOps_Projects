#!/bin/bash
sudo yum update -y && sudo yum install docker -y
sudo service docker start
sudo usermod -aG docker ec2-user
docker run -dt -p 8080:80 nginx

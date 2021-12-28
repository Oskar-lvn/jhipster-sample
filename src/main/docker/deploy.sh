#!/bin/sh
#setting up - installing dependencies for docker compose
#concider check if sudo instead to script
sudo yum install -y yum-utils &>> ./my_log_file.txt
sudo yum install -y docker  &>> ./my_log_file.txt
if sudo systemctl start docker &>> ./my_log_file.txt; then
   sudo docker pull eu.gcr.io/ohalo-poc/sampleapp &>> ./my_log_file.txt
else
   echo can not start docker
   exit
fi
sudo curl -L "https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  &>> ./my_log_file.txt
sudo chmod +x /usr/local/bin/docker-compose

if docker-compose --version &> ./my_log_file.txt; then
    #docker command    echo Deploying services
    sudo /usr/local/bin/docker-compose -f app.yml up -d
else
    echo docker-compose wasn not installed properly
fi

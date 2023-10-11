#!/bin/bash

# Update the system
sudo yum update -y

#Install ansible
sudo amazon-linux-extras install ansible2 -y

#Install python3
sudo yum install python3 -y

#Install boto3
pip3 install boto3

# Install Java Development Kit (JDK)
sudo amazon-linux-extras install java-openjdk11

# Install Git
sudo yum install -y git

# Install Docker
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# # Print initial Jenkins admin password
# echo "Jenkins initial admin password:"
# sudo cat /var/lib/jenkins/secrets/initialAdminPassword

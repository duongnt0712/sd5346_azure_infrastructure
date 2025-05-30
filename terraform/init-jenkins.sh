#!/bin/bash

# Update and install dependencies
sudo yum update -y
sudo yum install -y wget curl git

# Install Java first (required for Jenkins)
echo "Installing Java..."
sudo amazon-linux-extras enable corretto11  # Enable Corretto 11
sudo yum install -y java-17-amazon-corretto

# Install Jenkins
echo "Installing Jenkins..."
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y  # Ensure Jenkins repository is up to date
sudo yum install -y jenkins

# Install Docker
echo "Installing Docker..."
sudo yum install -y docker
sudo service docker start
sudo systemctl enable docker

# Add Jenkins to Docker group
sudo usermod -a -G docker jenkins

# === Install latest AWS CLI ===
echo "Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --update
rm -rf awscliv2.zip aws

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Start Jenkins service
echo "Starting Jenkins..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Output completion message
echo "Jenkins, Docker, Git, and kubectl have been successfully installed and started."
#!/bin/bash

echo "🔄 Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "🐳 Installing Docker..."
sudo apt install -y ca-certificates curl gnupg lsb-release software-properties-common apt-transport-https

# Add Docker’s GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "👤 Adding user 'ubuntu' to Docker group..."
sudo usermod -aG docker ubuntu
newgrp docker

echo "🔓 Setting Docker socket permissions..."
sudo chmod 666 /var/run/docker.sock

echo "✅ Docker installed successfully!"
docker --version

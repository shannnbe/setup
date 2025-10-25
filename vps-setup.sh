#!/bin/bash
set -e

echo "======================================"
echo "Nearby VPS Setup Script"
echo "======================================"

# Update system
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Docker
echo "Installing Docker..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add current user to docker group
echo "Adding user to docker group..."
sudo usermod -aG docker $USER

# Install Nginx
echo "Installing Nginx..."
sudo apt install -y nginx

# Install Certbot for Let's Encrypt
echo "Installing Certbot..."
sudo apt install -y certbot python3-certbot-nginx

# Create application directory
echo "Creating application directories..."
sudo mkdir -p /opt/nearby/{backend,frontend}
sudo chown -R $USER:$USER /opt/nearby

# Create deployment user (optional, for better security)
echo "Setup complete!"
echo ""
echo "======================================"
echo "IMPORTANT: Next Steps"
echo "======================================"
echo "1. Logout and login again for docker group changes to take effect"
echo "2. Verify Docker: docker --version"
echo "3. Verify Docker Compose: docker-compose --version"
echo "4. Configure GitHub Actions secrets (see deployment guide)"
echo "======================================"
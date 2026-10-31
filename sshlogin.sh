#!/bin/bash
# sudo apt install wget -y
# wget --no-check-certificate 'https://raw.githubusercontent.com/tamprimary/Proxy/main/sshlogin.sh' -O sshlogin.sh && sudo sh sshlogin.sh

echo "🚀 Starting automated VPS setup..."

# ==========================================
# 1. SSH Configuration
# ==========================================
echo "[1/3] Configuring SSH..."
# Automatically comment out 'PermitRootLogin no'
#file=/etc/ssh/sshd_config
#sudo sed -i 's/PermitRootLogin no/#PermitRootLogin no/' $file
sudo sed -i 's/^PermitRootLogin no/#PermitRootLogin no/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "✅ Setup completed successfully! The VPS is ready."

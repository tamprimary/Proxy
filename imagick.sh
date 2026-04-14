#!/bin/bash
# sudo apt install wget -y
# wget --no-check-certificate 'https://raw.githubusercontent.com/tamprimary/Proxy/main/imagick.sh' -O imagick.sh && sudo sh imagick.sh

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

# ==========================================
# 2. Apache Installation
# ==========================================
echo "[2/3] Installing Apache..."
sudo apt-get update -y
sudo apt-get install apache2 -y
sudo systemctl start apache2.service
sudo systemctl enable apache2

# UFW Firewall configuration (commented out for future customization):
# sudo ufw allow 'Apache Full'
# sudo ufw allow ssh
# sudo ufw allow 6868/tcp #Make sure to allow the Squid port though the firewall
# sudo ufw enable

# ==========================================
# 3. PHP & ImageMagick Installation
# ==========================================
echo "[3/3] Installing PHP & ImageMagick..."
sudo apt-get install php -y
sudo apt-get install -y php-{bcmath,bz2,intl,gd,mbstring,mcrypt,mysql,zip}
sudo apt-get install libapache2-mod-php -y
sudo apt install php php-common gcc -y	#Prerequsities
sudo apt install imagemagick -y			#Install ImageMagick
sudo apt install php-imagick -y			#Install imagick PHP Extension

# Verify Imagick module installation
echo "Checking Imagick module:"
php -m | grep imagick #Verify if imagick has been loaded as an extension

sudo systemctl restart apache2
sudo chown -R www-data /var/www/html

echo "✅ Setup completed successfully! The VPS is ready."
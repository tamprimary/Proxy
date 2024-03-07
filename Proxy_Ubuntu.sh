#!/bin/bash
# Link: https://drive.google.com/file/d/1Qixdexc2ffW31G-Ctd_JMaMwdVn9Ocs4/view?usp=sharing
# Direct Link: https://drive.google.com/uc?export=download&id=1Qixdexc2ffW31G-Ctd_JMaMwdVn9Ocs4
# sudo yum install wget -y
# wget --no-check-certificate 'https://bit.ly/3cpLVZg' -O proxy.sh && sudo sh proxy.sh
#
# sudo apt install wget -y
# wget --no-check-certificate 'http://34.67.111.150/Proxy_Ubuntu.sh' -O proxy.sh && sudo sh proxy.sh

#yum update -y
#sudo apt update

#yum install -y squid
sudo apt -y install squid #sudo apt install -y squid
sudo systemctl enable squid

#yum install -y httpd-tools
sudo apt -y install apache2-utils
sudo htpasswd -b -c /etc/squid/users_auth tamproxy 123456

#file=/root/squid.conf
file=/etc/squid/squid.conf

#acl myhome src xxx.xxx.xxx.xxx
#http_access allow myhome

cmt1='#=============================================================================='
cmt2='auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/users_auth'
cmt3='acl authenticated proxy_auth REQUIRED'
cmt4='http_access allow authenticated'
cmt5='#=============================================================================='

#Insert multiple lines before match found
sudo sed -i "/^http_access deny all.*/i $cmt1\n$cmt2\n$cmt3\n$cmt4\n$cmt5" $file

#Insert multiple lines after match found
#sudo sed -i "/^http_access deny all.*/a $cmt1\n$cmt2\n$cmt3\n$cmt4\n$cmt5" $file

# Change Squid listens to port 6868
sudo sed -i 's/http_port 3128/http_port 6868/' $file

sudo systemctl restart squid
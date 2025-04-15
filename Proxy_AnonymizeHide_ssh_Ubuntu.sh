#!/bin/bash
# Link: https://drive.google.com/file/d/1Qixdexc2ffW31G-Ctd_JMaMwdVn9Ocs4/view?usp=sharing
# Direct Link: https://drive.google.com/uc?export=download&id=1Qixdexc2ffW31G-Ctd_JMaMwdVn9Ocs4
# sudo yum install wget -y
# wget --no-check-certificate 'https://bit.ly/3cpLVZg' -O proxy.sh && sudo sh proxy.sh
#
# sudo apt install wget -y
# wget --no-check-certificate 'http://34.67.111.150/Proxy_Ubuntu.sh' -O proxy.sh && sudo sh proxy.sh
# wget --no-check-certificate 'http://34.67.111.150/Proxy_Anonymize_Ubuntu.sh' -O proxy.sh && sudo sh proxy.sh

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

sudo sed -i '1i\
# Hide client ip\
forwarded_for delete\
# Turn off via header\
via off\
request_header_access Allow allow all\
request_header_access Authorization allow all\
request_header_access WWW-Authenticate allow all\
request_header_access Proxy-Authorization allow all\
request_header_access Proxy-Authenticate allow all\
request_header_access Cache-Control allow all\
request_header_access Content-Encoding allow all\
request_header_access Content-Length allow all\
request_header_access Content-Type allow all\
request_header_access Date allow all\
request_header_access Expires allow all\
request_header_access Host allow all\
request_header_access If-Modified-Since allow all\
request_header_access Last-Modified allow all\
request_header_access Location allow all\
request_header_access Pragma allow all\
request_header_access Accept allow all\
request_header_access Accept-Charset allow all\
request_header_access Accept-Encoding allow all\
request_header_access Accept-Language allow all\
request_header_access Content-Language allow all\
request_header_access Mime-Version allow all\
request_header_access Retry-After allow all\
request_header_access Title allow all\
request_header_access Connection allow all\
request_header_access Proxy-Connection allow all\
request_header_access User-Agent allow all\
request_header_access Cookie allow all\
request_header_access All deny all\
#==============================================================================\
' /etc/squid/squid.conf
#https://www.linode.com/docs/guides/squid-http-proxy-debian-10/
#https://serverfault.com/questions/380392/squid-proxy-hiding-the-proxy
#https://www.iplocation.net/http-browser-header

ssh1='#=============================================================================='
ssh2='acl SSL_ports port 22		# ssh'
ssh3='acl Safe_ports port 22'
ssh4='#=============================================================================='

#Insert multiple lines before match found
sudo sed -i "/^acl Safe_ports port 80.*/i $ssh1\n$ssh2\n$ssh3\n$ssh4" $file

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
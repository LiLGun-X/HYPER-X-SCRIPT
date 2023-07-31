#!/bin/bash

IP=$(wget -4qO- "http://whatismyip.akamai.com/")
IPX=$(wget -qO- http://whatismyip.akamai.com/)

echo ""
echo "          ░▒█░▒█░▒█░░▒█░▒█▀▀█░▒█▀▀▀░▒█▀▀▄░░░░▀▄░▄▀"|lolcat
echo "          ░▒█▀▀█░▒▀▄▄▄▀░▒█▄▄█░▒█▀▀▀░▒█▄▄▀░▀▀░░▒█░░"|lolcat
echo "          ░▒█░▒█░░░▒█░░░▒█░░░░▒█▄▄▄░▒█░▒█░░░░▄▀▒▀▄"|lolcat
echo "
echo -e "\E[44;1;37m              ติดตั้ง SQUID PROXY               \E[0m"
	echo "|1| Install-ProxyServer"
	echo "|2| Restart/ProxyServer"
	echo ""
	read -p "Select a Function Script : " S

case $S in
1) # ==============================================
clear
echo -e "\E[44;1;37m              ติดตั้ง SQUID PROXY               \E[0m"
echo ""
echo "Server IP  : $IPX "
read -p "Port Proxy : " -e -i 8080 PROXY
echo ""
#Install squid
apt update
apt -y install squid

cp /etc/squid/squid.conf /etc/squid/squid.conf.orig
echo "acl localnet src 0.0.0.1-0.255.255.255  # RFC 1122 "this" network (LAN)
acl localnet src 10.0.0.0/8             # RFC 1918 local private network (LAN)
acl localnet src 100.64.0.0/10          # RFC 6598 shared address space (CGN)
acl localnet src 169.254.0.0/16         # RFC 3927 link-local (directly plugged>
acl localnet src 172.16.0.0/12          # RFC 1918 local private network (LAN)
acl localnet src 192.168.0.0/16         # RFC 1918 local private network (LAN)
acl localnet src fc00::/7               # RFC 4193 local private network range
acl localnet src fe80::/10              # RFC 4291 link-local (directly plugged>

acl SSL_ports port 443
acl Safe_ports port 80          # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443         # https
acl Safe_ports port 70          # gopher
acl Safe_ports port 210         # wais
acl Safe_ports port 1025-65535  # unregistered ports
acl Safe_ports port 280         # http-mgmt
acl Safe_ports port 488         # gss-http
acl Safe_ports port 591         # filemaker
acl Safe_ports port 777         # multiling http
acl CONNECT method CONNECT

acl ip_server dst $IPX-$IPX/255.255.255.255

http_access allow ip_server
http_access allow localhost manager
http_access deny manager
http_access allow localnet
http_access allow localhost
http_access deny all

http_port $PROXY
http_port 3128

cache_store_log none
cache_log /dev/null
logfile_rotate 0

via off
forwarded_for off
dns_v4_first on
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern \/(Packages|Sources)(|\.bz2|\.gz|\.xz)$ 0 0% 0 refresh-ims
refresh_pattern \/Release(|\.gpg)$ 0 0% 0 refresh-ims
refresh_pattern \/InRelease$ 0 0% 0 refresh-ims
refresh_pattern \/(Translation-.*)(|\.bz2|\.gz|\.xz)$ 0 0% 0 refresh-ims
refresh_pattern .               0       20%     4320
visible_hostname By TestX" > /etc/squid/squid.conf

/etc/init.d/squid start
/etc/init.d/squid restart

echo ""
	echo "Squid Proxy,Install finish."
	echo "Port Proxy : $PROXY"
	echo ""
	echo ""
	echo ""
        sleep 2.5
exit
;;
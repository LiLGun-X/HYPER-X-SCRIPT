#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[Installed]${Font_color_suffix}"
Error="${Red_font_prefix}[Not Installed]${Font_color_suffix}"
cek=$(netstat -ntlp | grep 10000 | awk '{print $7}' | cut -d'/' -f2)
function install () {
IP=$(wget -qO- ifconfig.co);
echo " Adding Repositori Webmin"
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
apt install gnupg gnupg1 gnupg2 -y
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
echo " Start Install Webmin"
clear
sleep 0.5
apt update > /dev/null 2>&1
apt install webmin -y
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
/etc/init.d/webmin restart
rm -f /root/jcameron-key.asc
clear
echo ""
echo " ติดตั้งสำเร็จแล้ว"
echo " $IP:10000"
echo " สคริปโดยเอเจ"​
}
function restart () {
echo " รีสตาร์ท​ เว็ปมิน"
sleep 0.5
service webmin restart > /dev/null 2>&1
echo " กำ​ลัง​รีสตาร์ทเว็ปมิน​"
clear
echo ""
echo " รีสตาร์ท​สำเร็จ"
echo " สคริปโดยเอเจ"​
}
function uninstall () {
echo " Removing Repositori Webmin"
rm -f /etc/apt/sources.list.d/webmin.list
apt update > /dev/null 2>&1
echo " เริ่มถอนการติดตั้งเว็ปมิน"
clear
sleep 0.5
apt autoremove --purge webmin -y > /dev/null 2>&1
clear
echo ""
echo " ถอนการติดตั้งสำเร็จ"
echo " สคริปโดยเอเจ"​
}
if [[ "$cek" = "perl" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e " ******************************"
echo -e "           เว็ปมินเมนู         "
echo -e " ******************************"
echo -e "          สคริปโดยเอเจ"​
echo -​e "" 
echo -e " สถานะ $sts"
echo -e "  1. ติดตั้ง​ Webmin"
echo -e "  2. รีสตาร์ท​ Webmin"
echo -e "  3. ถอนการติดตั้ง Webmin"
echo -e " พิมพ์ CTRL+C เพื่อย้อนกลับ"
read -rp " โปรดใส่คำสั่งให้ถูกต้อง : " -e num
if [[ "$num" = "1" ]]; then
install
elif [[ "$num" = "2" ]]; then
restart
elif [[ "$num" = "3" ]]; then
uninstall
else
clear
echo " คำสั่งไม่ถูกต้อง"
menu
fi

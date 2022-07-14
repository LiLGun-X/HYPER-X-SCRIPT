#!/bin/bash
# Functions
#OS
if [[ -e /etc/debian_version ]]; then
VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
fi

# IP Address
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
if [ -e '/etc/squid3/squid.txt' ]; then
echo ""
clear
else
echo "" > /etc/squid3/squid.txt
fi
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="10"' ]]; then
if [ -e '/etc/squid/squid.txt' ]; then
echo ""
clear
else
echo "" > /etc/squid/squid.txt
fi
fi

IP=$(wget -qO- ipv4.icanhazip.com);
if [[ "$IP" = "" ]]; then
    IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | grep -v '192.168'`;
fi


ok() {
    echo -e '\e[32m'$1'\e[m';
}

die() {
    echo -e '\e[1;35m'$1'\e[m';
}

des() {
    echo -e '\e[1;31m'$1'\e[m'; exit 1;
}
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣ ⚙⚙⚙ การตั้งค่า Proxy ⚙⚙⚙ "
echo " ┈╰━━┳━━━━━━━━━━━━┳━━━━━╯ "
echo " ┈╭━━┻━━━━━━━━━━━━┻━━━━━╮ "
echo " ┈┣  1. เปิด-ปิด ใช้งาน Proxy Server "
echo " ┈┣  2. เพิ่ม IP ที่จะใช้งาน Proxy Server นี้     "
echo " ┈┣  3. ตั้งค่าพอร์ต    "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
echo " "
 read -p " ┈╰┫พิมพ์ตัวเลข  : " kguza

if [[ "$kguza" = "" ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  โปรดพิมพ์คำสั่งโดยใส่ตัวเลข "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
 exit
fi
if [[ "1" = "$kguza" ]]; then
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
grep -E "^http_access allow all" /etc/squid3/squid.conf >/dev/null
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="10"' ]]; then
grep -E "^http_access allow all" /etc/squid/squid.conf >/dev/null
fi
 if [ $? -eq 0 ]; then
 clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  สถานะปัจจุบัน ใช้ใด้ทุก Server "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
echo " "
read -p " ┈╰┫เปลี่ยนเป็นใช้ใด้เฉพาะ Server นี่หรือไม่ Y/N :" selet
if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
sed -i "s/http_access allow all/http_access allow localhost/g" /etc/squid3/squid.conf
ok "❯❯❯ service squid3 restart"
service squid3 restart -q > /dev/null 2>&1
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' || "$VERSION_ID" = 'VERSION_ID="10"' ]]; then
sed -i "s/http_access allow all/http_access allow localhost/g" /etc/squid/squid.conf
ok "❯❯❯ service squid restart"
service squid restart -q > /dev/null 2>&1
fi
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  สถานะปัจจุบัน ใช้ใด้เฉพาะ Server นี้ "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit
fi
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  สถานะปัจจุบัน ใช้ใด้ทุก Server "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
proxy
exit
 else
 clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  สถานะปัจจุบัน ใช้ใด้เฉพาะ Server นี้ "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
echo " "
read -p " ┈╰┫เปลี่ยนเป็นใช้ใด้ทุก Server หรือไม่ Y/N :" selet
if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
sed -i "s/http_access allow localhost/http_access allow all/g" /etc/squid3/squid.conf
ok "❯❯❯ service squid3 restart"
service squid3 restart -q > /dev/null 2>&1
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
sed -i "s/http_access allow localhost/http_access allow all/g" /etc/squid/squid.conf
ok "❯❯❯ service squid restart"
service squid restart -q > /dev/null 2>&1
fi
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  สถานะเปลี่ยนเป็น ใช้ใด้ทุก Server "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ $IP:8080 เป็น Proxy Server สำเร็จ"
echo " ┈┣ $IP:8000 เป็น Proxy Server สำเร็จ"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
echo -e ""

exit
fi
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  สถานะปัจจุบัน ใช้ใด้เฉพาะ Server นี้ "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
proxy
exit
fi
elif [[ "2" = "$kguza" ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  เลือกใช้คำสั่ง โดยการพิมพ์ตัวเลข"
echo " ┈╰━━┳━━━━━━━━━━━━┳━━━━━╯ "
echo " ┈╭━━┻━━━━━━━━━━━━┻━━━━━╮ "
echo " ┈┣  1. เพิ่มไอพี "
echo " ┈┣  2. เช็คไอพี     "
echo " ┈┣  3. ลบไอพี          "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
echo " "
 read -p " ┈┣ พิมพ์ตัวเลข : " Selet
 if [[ "$Selet" = "" ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  โปรดพิมพ์คำสั่งโดยใส่ตัวเลข "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
 exit
fi
 if [[ $Selet = 1 ]]; then
 read -p " ┈┣ ใส่เลขไอพีที่จะใช้งานพร็อกซี่นี้ : " SERVER_IP
 read -p " ┈┣ บันทึกการตั้งค่านี้ Y/N : " YN
 if [[ n = $YN || N = $YN ]]; then
 clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  $SERVER_IP ไม่ได้ยืนยันการใช้งาน "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit 
 fi
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
grep -E "^acl SSH dst $SERVER_IP" /etc/squid3/squid.conf >/dev/null
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
grep -E "^acl SSH dst $SERVER_IP" /etc/squid/squid.conf >/dev/null
fi
if [ $? -eq 0 ]; then
 clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  $SERVER_IP มีอยู่ในระบบแล้ว "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit
else
echo
fi

 
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
sed -i "/acl CONNECT method CONNECT/a acl SSH dst $ipdovps-$ipdovps\/255.255.255.255" /etc/squid3/squid.conf
sed -i "s/xxxxxxxxxx/$SERVER_IP/g" /etc/squid3/squid.conf
echo " ┈┣ $SERVER_IP " >> /etc/squid3/squid.txt
ok "❯❯❯ service squid3 restart"
service squid3 restart -q > /dev/null 2>&1
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
sed -i "/acl CONNECT method CONNECT/a acl SSH dst $ipdovps-$ipdovps\/255.255.255.255" /etc/squid/squid.conf
sed -i "s/$ipdovps/$SERVER_IP/g" /etc/squid/squid.conf
echo " ┈┣ $SERVER_IP " >> /etc/squid/squid.txt
ok "❯❯❯ service squid restart"
service squid restart -q > /dev/null 2>&1
fi
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  เปิดใช้งาน $SERVER_IP เรียบร้อย "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit 
elif [[ $Selet = 2 ]]; then
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
grep -E "^http_access allow all" /etc/squid3/squid.conf >/dev/null
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
grep -E "^http_access allow all" /etc/squid/squid.conf >/dev/null
fi
 if [ $? -eq 0 ]; then
 clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  สถานะปัจจุบัน ใช้ใด้ทุก Server "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit
else

clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ไอพีที่เปิดใช้งานอยู่ในปัจจุบัน "
echo " ┈╰━━┳━━━━━━━━━━━━┳━━━━━╯ "
echo " ┈╭━━┻━━━━━━━━━━━━┻━━━━━╮ "
echo " ┈┣ $IP  "
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
cat /etc/squid3/squid.txt
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯
"
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
cat /etc/squid/squid.txt
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯"
fi
exit
fi
elif [[ $Selet = 3 ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  เลือกใช้คำสั่ง โดยการพิมพ์ตัวเลข"
echo " ┈┣  ลบไอพีพร็อกซี่"
echo " ┈╰━━┳━━━━━━━━━━━━┳━━━━━╯ "
echo " ┈╭━━┻━━━━━━━━━━━━┻━━━━━╮ "
echo " ┈┣  1. ลบบางไอพี  "
echo " ┈┣  2. รีเซ็ตค่าเดิม  "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
read -p " ┈┣ พิมพ์ตัวเลข : " Selet1
if [[ $Selet1 = 1 ]]; then
read -p " ┈┣ ใส่เลขไอพีที่จะลบ : " SERVER_IP
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
grep -E "^acl SSH dst $SERVER_IP" /etc/squid3/squid.conf >/dev/null
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
grep -E "^acl SSH dst $SERVER_IP" /etc/squid/squid.conf >/dev/null
fi

if [ $? -eq 0 ]; then
if [[ $SERVER_IP = $IP ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ไม่อณุญาตให้ลบไอพีของเซิร์ฟเวอร์นี้ "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
 exit
fi
 read -p " ┈┣ ยืนยันการลบไอพี Y/N : " YN
else
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ไม่พบ IP $SERVER_IP ในระบบ "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit
fi

if [[ $YN = N || $YN = n ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ยกเลิกการเปลี่ยนแปลง "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
 exit
fi


if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
SERVER_IP2="/$SERVER_IP/d";
sed -i $SERVER_IP2 /etc/squid3/squid.txt
sed -i $SERVER_IP2 /etc/squid3/squid.conf
sed -i '/^$/d' /etc/squid3/squid.txt
sed -i '/^$/d' /etc/squid3/squid.conf
echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสักครู่..."
service squid3 restart -q > /dev/null 2>&1
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
SERVER_IP2="/$SERVER_IP/d";
sed -i $SERVER_IP2 /etc/squid/squid.txt
sed -i $SERVER_IP2 /etc/squid/squid.conf
sed -i '/^$/d' /etc/squid/squid.txt
sed -i '/^$/d' /etc/squid/squid.conf
echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสักครู่..."
service squid restart -q > /dev/null 2>&1
fi
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ลบไอพี $SERVER_IP เรียบร้อย "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit
elif [[ $Selet1 = 2 ]]; then
read -p " ┈┣ ยืนยันการลบไอพีทั้งหมด Y/N : " YN
if [[ $YN = N || $YN = n ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ยกเลิกการเปลี่ยนแปลง "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
 exit
fi
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
SERVER_IP2="/255.255.255.255/d";
sed -i $SERVER_IP2 /etc/squid3/squid.txt
sed -i $SERVER_IP2 /etc/squid3/squid.conf
sed -i '/^$/d' /etc/squid3/squid.txt
sed -i '/^$/d' /etc/squid3/squid.conf
sed -i "/acl CONNECT method CONNECT/a acl SSH dst $ipdovps-$ipdovps\/255.255.255.255" /etc/squid3/squid.conf
sed -i "s/$ipdovps/$IP/g" /etc/squid3/squid.conf
echo "" > /etc/squid3/squid.txt
sed -i '/^$/d' /etc/squid3/squid.txt
ok "❯❯❯ กำลังเปิดใช้งานตั้งค่าใหม่ รอสักครู่..."
service squid3 restart -q > /dev/null 2>&1
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
SERVER_IP2="/255.255.255.255/d";
sed -i $SERVER_IP2 /etc/squid/squid.txt
sed -i $SERVER_IP2 /etc/squid/squid.conf
sed -i '/^$/d' /etc/squid/squid.conf
sed -i "/acl CONNECT method CONNECT/a acl SSH dst $ipdovps-$ipdovps\/255.255.255.255" /etc/squid/squid.conf
sed -i "s/$ipdovps/$IP/g" /etc/squid/squid.conf
echo "" > /etc/squid/squid.txt
sed -i '/^$/d' /etc/squid/squid.txt
ok "❯❯❯ กำลังเปิดใช้งานตั้งค่าใหม่ รอสักครู่..."
service squid restart -q > /dev/null 2>&1
fi
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ลบไอพีทั้งหมด เรียบร้อย"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit
fi
fi
elif [[ "3" = "$kguza" ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  เลือกใช้คำสั่ง โดยการพิมพ์ตัวเลข"
echo " ┈╰━━┳━━━━━━━━━━━━┳━━━━━╯ "
echo " ┈╭━━┻━━━━━━━━━━━━┻━━━━━╮ "
echo " ┈┣  1. เพิ่มพอร์ต Proxy "
echo " ┈┣  2. เช็ดพอร์ต Proxy "
echo " ┈┣  3. ลบพอร์ต Proxy "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
echo " "
 read -p " ┈┣ พิมพ์ตัวเลข : " Selet
 if [[ "$Selet" = "" ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  โปรดพิมพ์คำสั่ง"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
 exit
fi
 if [[ $Selet = 1 ]]; then
 read -p " ┈┣ ใส่พอร์ตที่จะใช้งานกับพร็อกซี่ : " Port
 if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
grep -E "^http_port $Port" /etc/squid3/squid.conf >/dev/null
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
grep -E "^http_port $Port" /etc/squid/squid.conf >/dev/null
fi

if [ $? -eq 0 ]; then
 clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  Port $Port มีอยู่ในระบบแล้ว"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit
else
if [[ $Port = 80 || $Port = 443 || $Port = 22 || $Port = 143 || $Port = 444 || $Port = 10000 || $Port = 1194 || $Port = 9000 || $Port = 1 || $Port = 2 || $Port = 3 || $Port = 4 || $Port = 5 || $Port = 6 || $Port = 7 || $Port = 8 || $Port = 9 || $Port = 0 || $Port = 21 || $Port = 70 || $Port = 210 || $Port = 1025 || $Port = 65535 || $Port = 280 || $Port = 488 || $Port = 591 || $Port = 777 || $Port = 255 || $Port = 10 || $Port = 172 || $Port = 127 || $Port = 192 || $Port = 32 || $Port = 12 || $Port = 16 || $Port = 1440 || $Port = 20 || $Port = 10080 || $Port = 4320 || $Port = 3128 || $Port = 5555 ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  Port $Port ไม่สามารถเปิดใช้งานได้"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  PORT ที่ห้ามใช้มีดังนี้"
echo " ┈╰━━┳━━━━━━━━━━━━┳━━━━━╯ "
echo " ┈╭━━┻━━━━━━━━━━━━┻━━━━━╮ "
echo " ┈┣  80•443•22•143•444•10000•1194 "
echo " ┈┣  9000•21•70•210•1025•65535•280 "
echo " ┈┣  488•591•777•255•10•172•127•3128 "
echo " ┈┣  32•12•16•1440•20•10080•4320•192 "
echo " ┈┣  5555•และ0ถึง9"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
echo " "
exit
fi
read -p " ┈┣ ยืนยันการตั้งค่า Y/N : " YN
fi
 if [[ n = $YN || N = $YN ]]; then
 clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  $Port ไม่ได้ยืนยันการใช้งาน"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit 
 fi


 
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
sed -i "/http_port 8080/a http_port xxxx" /etc/squid3/squid.conf
sed -i "s/xxxx/$Port/g" /etc/squid3/squid.conf
echo " ┈┣ http_port $Port " >> /etc/squid3/port.txt
echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสักครู่..."
service squid3 restart -q > /dev/null 2>&1
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
sed -i "/http_port 8080/a http_port xxxx" /etc/squid/squid.conf
sed -i "s/xxxx/$Port/g" /etc/squid/squid.conf
echo " ┈┣ http_port $Port  " >> /etc/squid/port.txt
echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสักครู่..."
service squid restart -q > /dev/null 2>&1
fi
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  Port $Port พร้อมใช้งาน"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit 
elif [[ $Selet = 2 ]]; then

clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  พอร์ตที่เปิดใช้งานอยู่ปัจจุบัน "
echo " ┈╰━━┳━━━━━━━━━━━━┳━━━━━╯ "
echo " ┈╭━━┻━━━━━━━━━━━━┻━━━━━╮ "
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
cat /etc/squid3/port.txt
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯
"
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
cat /etc/squid/port.txt
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯"
exit
fi

elif [[ $Selet = 3 ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  เลือกใช้คำสั่ง โดยการพิมพ์ตัวเลข"
echo " ┈┣  ลบพอร์ตพร็อกซี่"
echo " ┈╰━━┳━━━━━━━━━━━━┳━━━━━╯ "
echo " ┈╭━━┻━━━━━━━━━━━━┻━━━━━╮ "
echo " ┈┣  1. ลบบางพอร์ต  "
echo " ┈┣  2. รีเซ็ตค่าเริ่มต้น  "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
read -p " ┈┣ พิมพ์ตัวเลข : " Selet1
if [[ $Selet1 = 1 ]]; then
read -p " ┈┣ ใส่เลขพอร์ตที่จะลบ : " Port
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
grep -E "^http_port $Port" /etc/squid3/squid.conf >/dev/null
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
grep -E "^http_port $Port" /etc/squid/squid.conf >/dev/null
fi
if [ $? -eq 0 ]; then
if [[ $Port = 8080 ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ไม่อณุญาตให้ลบพอร์ต 8080"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
 exit
fi
 read -p " ┈┣ ยืนยันการลบพอร์ต Y/N : " YN
else
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ไม่พบ Port $Port ในระบบ"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit
fi


if [[ $YN = N || $YN = n ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ยกเลิกการเปลี่ยนแปลง "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
 exit
fi

if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
SERVER_IP2="/$Port/d";
sed -i $SERVER_IP2 /etc/squid3/port.txt
sed -i $SERVER_IP2 /etc/squid3/squid.conf
sed -i '/^$/d' /etc/squid3/port.txt
sed -i '/^$/d' /etc/squid3/squid.conf
echo " ╰ กำลังเปิดใช้งานตั้งค่าใหม่ รอสักครู่..."
service squid3 restart -q > /dev/null 2>&1
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
SERVER_IP2="/$Port/d";
sed -i $SERVER_IP2 /etc/squid/port.txt
sed -i $SERVER_IP2 /etc/squid/squid.conf
sed -i '/^$/d' /etc/squid/port.txt
sed -i '/^$/d' /etc/squid/squid.conf
ok "❯❯❯ กำลังเปิดใช้งานตั้งค่าใหม่ รอสักครู่..."
service squid restart -q > /dev/null 2>&1
fi
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ลบพอร์ต $Port เรียบร้อย "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
 exit
elif [[ $Selet1 = 2 ]]; then
read -p " ┈┣ ยืนยันรีเซ็ตค่าเดิม Y/N : " YN
if [[ $YN = N || $YN = n ]]; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ยกเลิกการรีเซ็ต "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
 exit
fi
if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
SERVER_IP2="/http_port/d";
sed -i $SERVER_IP2 /etc/squid3/port.txt
sed -i $SERVER_IP2 /etc/squid3/squid.conf
sed -i '/^$/d' /etc/squid3/port.txt
sed -i '/^$/d' /etc/squid3/squid.conf
sed -i "/http_access allow SSH/a http_port 8080" /etc/squid3/squid.conf
echo " ┈┣ http_port 8080 " > /etc/squid3/port.txt
sed -i '/^$/d' /etc/squid3/port.txt
ok "❯❯❯ กำลังเปิดใช้งานตั้งค่าใหม่ รอสักครู่..."
service squid3 restart -q > /dev/null 2>&1
elif [[ "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="9"' ]]; then
SERVER_IP2="/http_port/d";
sed -i $SERVER_IP2 /etc/squid/port.txt
sed -i $SERVER_IP2 /etc/squid/squid.conf
sed -i '/^$/d' /etc/squid/squid.conf
sed -i "/http_access allow SSH/a http_port 8080" /etc/squid/squid.conf
echo " ┈┣ http_port 8080 " > /etc/squid/port.txt
sed -i '/^$/d' /etc/squid/port.txt
ok "❯❯❯ กำลังเปิดใช้งานตั้งค่าใหม่ รอสักครู่..."
service squid restart -q > /dev/null 2>&1
fi
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  รีเซ็ตพอร์ค่าเดิมเรียบร้อย "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━╯ "
exit
fi
fi
fi


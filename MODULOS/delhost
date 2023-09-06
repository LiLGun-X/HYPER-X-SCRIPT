#!/bin/bash
if [ -d "/etc/squid/" ]; then
    payload="/etc/squid/payload.txt"
elif [ -d "/etc/squid3/" ]; then
	payload="/etc/squid3/payload.txt"
fi
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-10s\n' "ลบ Host จาก Squid Proxy" ; tput sgr0
if [ ! -f "$payload" ]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "ไฟล์ $payload ไม่พบ" ; tput sgr0
	exit 1
else
	tput setaf 2 ; tput bold ; echo ""; echo "โดเมนปัจจุบันในไฟล์ $payload:" ; tput sgr0
	tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
	read -p "ป้อนโดเมนที่คุณต้องการลบออกจากรายการ: " host
	if [[ -z $host ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "คุณได้ป้อนโดเมนที่ว่างเปล่าหรือไม่มีอยู่จริง!" ; echo "" ; tput sgr0
			exit 1
		else
		if [[ `grep -c "^$host" $payload` -ne 1 ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "โดเมน $host ไม่พบในไฟล์ $payload" ; echo "" ; tput sgr0
			exit 1
		else
			grep -v "^$host" $payload > /tmp/a && mv /tmp/a $payload
			tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "ไฟล์ $payload อัปเดต ลบโดเมนเรียบร้อยแล้ว:" ; tput sgr0
			tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
			if [ ! -f "/etc/init.d/squid3" ]
			then
				service squid3 reload
			elif [ ! -f "/etc/init.d/squid" ]
			then
				service squid reload
			fi	
			tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "Proxy Squid โหลด Proxy เรียบร้อยแล้ว!" ; echo "" ; tput sgr0
			exit 1
		fi
	fi
fi

#!/bin/bash
if [ -d "/etc/squid/" ]; then
    payload="/etc/squid/payload.txt"
elif [ -d "/etc/squid3/" ]; then
	payload="/etc/squid3/payload.txt"
fi
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-10s\n' "เพิ่มโฮสต์ไปยัง Squid Proxy" ; tput sgr0
if [ ! -f "$payload" ]
then
	tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "ไฟล์ $payload ไม่พบ" ; tput sgr0
	exit 1
else
	tput setaf 2 ; tput bold ; echo ""; echo "โดเมนปัจจุบันในไฟล์ $payload:" ; tput sgr0
	tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
	read -p "ป้อนโดเมนที่คุณต้องการเพิ่มในรายการ: " host
	if [[ -z $host ]]
	then
		tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "ป้อนโดเมนที่คุณต้องการเพิ่มในรายการ!" ; echo "" ; tput sgr0
		exit 1
	else
		if [[ `grep -c "^$host" $payload` -eq 1 ]]
		then
			tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "โดเมน $host มีอยู่แล้วในไฟล์ $payload" ; echo "" ; tput sgr0
			exit 1
		else
			if [[ $host != \.* ]]
			then
				tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "มีอยู่แล้วในไฟล์!" ; echo "For example: .phreaker56.xyz" ; echo "ไม่จำเป็นต้องเพิ่มโดเมนย่อยสำหรับโดเมนที่มีอยู่แล้วในไฟล์" ; echo "ไม่จำเป็นต้องเพิ่ม recargawap.claro.com.br" ; echo "หากโดเมน .claro.com.br มีไฟล์อยู่แล้ว." ; echo ""; tput sgr0
				exit 1
			else
				echo "$host" >> $payload && grep -v "^$" $payload > /tmp/a && mv /tmp/a $payload
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "ไฟล์ $payload อัพเดท, เพิ่มโดเมนสำเร็จแล้ว:" ; tput sgr0
				tput setaf 3 ; tput bold ; echo "" ; cat $payload ; echo "" ; tput sgr0
				if [ ! -f "/etc/init.d/squid3" ]
				then
					service squid3 reload
				elif [ ! -f "/etc/init.d/squid" ]
				then
					service squid reload
				fi	
				tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "ติดตั้ง Proxy Squid เรียบร้อยแล้ว!" ; echo "" ; tput sgr0
				exit 1
			fi
		fi
	fi
fi

#!/bin/bash

# ขอข้อมูลจากผู้ใช้งาน
read -p "Enter your username: " username
read -s -p "Enter your password: " password
echo
read -p "Enter your VPS hostname or IP: " hostname_or_ip

# เรียกใช้ sshpass เพื่อเข้า SSH เข้าสู่ VPS
sshpass -p "$password" ssh "$username"@"$hostname_or_ip"

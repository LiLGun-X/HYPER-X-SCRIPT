#!/bin/bash

# กำหนดตัวแปรสำหรับที่ตั้งของไฟล์การกำหนดค่า OpenVPN Server
config_file="/etc/openvpn/server.conf"

# กำหนดชื่อไฟล์สำหรับเก็บข้อมูลการเข้าสู่ระบบ
auth_file="auth.txt"

# แสดงข้อความและคำสั่งที่ต้องกรอกข้อมูลการเข้าสู่ระบบ
echo "Enter username:"
read username
echo "Enter password:"
read -s password

# สร้างไฟล์และเขียนชื่อผู้ใช้และรหัสผ่านลงไปในไฟล์
echo -e "$username\n$password" > $auth_file

# เพิ่มคำสั่ง auth-user-pass ในไฟล์การกำหนดค่า OpenVPN Server
echo "auth-user-pass $auth_file" >> $config_file

# รีสตาร์ท OpenVPN Server
systemctl restart openvpn@server.service

echo "OpenVPN authentication configuration complete!"

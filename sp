#!/bin/bash

# กำหนดอินเทอร์เฟซของ OpenVPN
OPENVPN_INTERFACE="tun0"

# คำสั่งสำหรับดูแบนด์วิดท์ดาวน์โหลดและอัพโหลด
rx_bytes=$(ifconfig $OPENVPN_INTERFACE | grep 'RX packets' | awk '{print $5}')
tx_bytes=$(ifconfig $OPENVPN_INTERFACE | grep 'TX packets' | awk '{print $5}')

# แปลงแบนด์วิดท์จากไบต์เป็นหน่วย MB, GB, TB
rx_mbps=$(echo "scale=2; $rx_bytes / 1024 / 1024 * 8" | bc)
tx_mbps=$(echo "scale=2; $tx_bytes / 1024 / 1024 * 8" | bc)

# แปลงให้อยู่ในหน่วย GB หรือ TB ตามขนาดข้อมูล
if [ $(echo "$rx_mbps > 1024" | bc -l) -eq 1 ]; then
    rx_gbps=$(echo "scale=2; $rx_mbps / 1024" | bc)
    if [ $(echo "$rx_gbps > 1024" | bc -l) -eq 1 ]; then
        rx_tbps=$(echo "scale=2; $rx_gbps / 1024" | bc)
        rx_bandwidth="Download: $rx_tbps TB"
    else
        rx_bandwidth="Download: $rx_gbps GB"
    fi
else
    rx_bandwidth="Download: $rx_mbps MB"
fi

if [ $(echo "$tx_mbps > 1024" | bc -l) -eq 1 ]; then
    tx_gbps=$(echo "scale=2; $tx_mbps / 1024" | bc)
    if [ $(echo "$tx_gbps > 1024" | bc -l) -eq 1 ]; then
        tx_tbps=$(echo "scale=2; $tx_gbps / 1024" | bc)
        tx_bandwidth="Upload: $tx_tbps TB"
    else
        tx_bandwidth="Upload: $tx_gbps GB"
    fi
else
    tx_bandwidth="Upload: $tx_mbps MB"
fi

# แสดงผลรายงานแบนด์วิดท์
echo "OpenVPN Bandwidth Usage"
echo $rx_bandwidth
echo $tx_bandwidth

# กำหนดวันที่สำหรับรายงาน (ตัวอย่างเช่นวันที่ 1 ของแต่ละเดือน)
REPORT_DATE=$(date +%d)

# กำหนดเดือนที่สำหรับรายงาน (ตัวอย่างเช่นเดือน 1 ของแต่ละปี)
REPORT_MONTH=$(date +%m)

# กำหนดตำแหน่งของ vnstat
VNSTAT_PATH="/usr/bin/vnstat"

# ฟังก์ชันรายงานแบนด์วิดท์รายวัน
report_daily_bandwidth() {
    echo "OpenVPN Daily Bandwidth Usage"
    $VNSTAT_PATH -d -i tun0
}

# ฟังก์ชันรายงานแบนด์วิดท์รายสัปดาห์
report_weekly_bandwidth() {
    echo "OpenVPN Weekly Bandwidth Usage"
    $VNSTAT_PATH -w -i tun0
}

# ฟังก์ชันรายงานแบนด์วิดท์รายเดือน
report_monthly_bandwidth() {
    echo "OpenVPN Monthly Bandwidth Usage"
    $VNSTAT_PATH -m -i tun0
}

# ตรวจสอบว่าต้องรายงานรายวัน, รายสัปดาห์, หรือรายเดือน
if [ "$REPORT_DATE" = "01" ]; then
    report_monthly_bandwidth
else
    report_daily_bandwidth
fi

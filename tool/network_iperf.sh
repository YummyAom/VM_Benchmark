#!/bin/bash

# -------------------------------
# Config
# -------------------------------
OUT="results/network.txt"
SERVER_IP="192.168.56.10"   # แก้เป็น IP ของ server
TEST_DURATION=10            # เวลา run test (วินาที)
PORT=5201                   # default iPerf3 port

# -------------------------------
# สร้างโฟลเดอร์เก็บผล
# -------------------------------
mkdir -p results

echo "=== IPERF3 NETWORK TEST ===" | tee $OUT
date | tee -a $OUT

# -------------------------------
# ตรวจสอบว่า server reachable
# -------------------------------
ping -c 1 $SERVER_IP > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "ERROR: Server $SERVER_IP not reachable!" | tee -a $OUT
    exit 1
fi

# -------------------------------
# รัน iPerf3
# -------------------------------
iperf3 -c $SERVER_IP -p $PORT -t $TEST_DURATION | tee -a $OUT

# -------------------------------
# สรุปผล
# -------------------------------
echo "=== NETWORK TEST COMPLETED ===" | tee -a $OUT
date | tee -a $OUT

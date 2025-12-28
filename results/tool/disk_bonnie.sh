#!/bin/bash

OUT="results/disk.txt"
SUMMARY_DIR="results/summary"
SUMMARY_FILE="$SUMMARY_DIR/disk.txt"

mkdir -p results
mkdir -p "$SUMMARY_DIR"

echo "=== BONNIE++ DISK TEST (RAW OUTPUT) ===" | tee "$OUT"

bonnie++ -d /tmp -s 2G -r 1024 -x 1 -b | tee -a "$OUT"

CSV_LINE=$(grep '^1\.' "$OUT")

WRITE_BLOCK=$(echo "$CSV_LINE" | awk -F',' '{print $13}')
REWRITE_BLOCK=$(echo "$CSV_LINE" | awk -F',' '{print $15}')
READ_BLOCK=$(echo "$CSV_LINE" | awk -F',' '{print $17}')

{
  echo "=== DISK SUMMARY ==="
  echo "Write Speed (Block)   : ${WRITE_BLOCK} KB/s"
  echo "Rewrite Speed        : ${REWRITE_BLOCK} KB/s"
  echo "Read Speed (Block)   : ${READ_BLOCK} KB/s"
  echo "Path Tested          : /tmp"
  echo "Host                 : $(hostname)"
  echo "Time                 : $(date)"
  echo ""
} | tee "$SUMMARY_FILE"

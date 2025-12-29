#!/bin/bash

# Base directories
BASE_DIR=$(pwd)
RESULTS_DIR="$BASE_DIR/results"
SUMMARY_DIR="$RESULTS_DIR/summary"

# สร้าง directories
mkdir -p "$RESULTS_DIR"
mkdir -p "$SUMMARY_DIR"

# Generate timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Output files
OUT="$RESULTS_DIR/disk_$TIMESTAMP.txt"
SUMMARY_FILE="$SUMMARY_DIR/disk_$TIMESTAMP.txt"

# Run bonnie++ benchmark
echo "=== BONNIE++ DISK TEST (RAW OUTPUT) ===" | tee "$OUT"
bonnie++ -d /tmp -s 2G -r 1024 -x 1 -b | tee -a "$OUT"

# Extract CSV line (first line starting with 1.)
CSV_LINE=$(grep '^1\.' "$OUT")

# Extract block speeds
WRITE_BLOCK=$(echo "$CSV_LINE" | awk -F',' '{print $13}')
REWRITE_BLOCK=$(echo "$CSV_LINE" | awk -F',' '{print $15}')
READ_BLOCK=$(echo "$CSV_LINE" | awk -F',' '{print $17}')

# Write summary
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

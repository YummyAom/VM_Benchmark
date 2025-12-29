#!/bin/bash

# Base directories
BASE_DIR=$(pwd)
RESULTS_DIR="$BASE_DIR/results"
SUMMARY_DIR="$RESULTS_DIR/summary"

# Create directories
mkdir -p "$RESULTS_DIR"
mkdir -p "$SUMMARY_DIR"

# Generate timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Output files
OUT="$RESULTS_DIR/memory_$TIMESTAMP.txt"
SUMMARY_FILE="$SUMMARY_DIR/memory_$TIMESTAMP.txt"

# Run benchmark
echo "=== MEMORY SYSBENCH ===" | tee "$OUT"
sysbench memory run | tee -a "$OUT"

MEM_SPEED=$(grep "MiB/sec" "$OUT" | awk '{print $(NF-1), $NF}')

MAX_LATENCY=$(grep "max:" "$OUT" | awk '{print $2, $3}')

{
  echo "=== MEMORY SUMMARY ==="
  echo "Memory Transfer Speed: $MEM_SPEED"
  echo "Max Latency: $MAX_LATENCY"
  echo "Host: $(hostname)"
  echo "Time: $(date)"
  echo ""
} | tee "$SUMMARY_FILE"

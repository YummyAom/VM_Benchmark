#!/bin/bash

# Base directory (ตำแหน่งที่รันสคริปต์)
BASE_DIR=$(pwd)

# Output file
OUT="$BASE_DIR/results/cpu.txt"

# Create results directory if it doesn't exist
mkdir -p "$BASE_DIR/results"

# Header
echo "=== CPU BENCHMARK (GEEKBENCH) ===" | tee "$OUT"

# Change to Geekbench directory
cd "$BASE_DIR/Geekbench-6.5.0-Linux" || exit 1

# Run Geekbench and append output
./geekbench6 | tee -a "$OUT"

# Go back to base directory
cd "$BASE_DIR"

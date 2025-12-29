#!/bin/bash

# Base directory
BASE_DIR=$(pwd)

# Create results directory if it doesn't exist
mkdir -p "$BASE_DIR/results"

# Generate output file with timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUT="$BASE_DIR/results/cpu_$TIMESTAMP.txt"

# Header
echo "=== CPU BENCHMARK (GEEKBENCH) ===" | tee "$OUT"

# Change to Geekbench directory
cd "$BASE_DIR/Geekbench-6.5.0-Linux" || exit 1

# Run Geekbench and append output
./geekbench6 | tee -a "$OUT"

# Go back to base directory
cd "$BASE_DIR"

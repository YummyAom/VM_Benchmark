#!/bin/bash
OUT="results/7zip.txt"

echo "=== 7ZIP COMPRESSION ===" | tee $OUT
7z b | tee -a $OUT


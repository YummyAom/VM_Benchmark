#!/bin/bash
OUT="results/kernel_build.txt"

echo "=== KERNEL BUILD TEST ===" | tee $OUT
phoronix-test-suite benchmark build-linux-kernel | tee -a $OUT

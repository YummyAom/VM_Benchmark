#!/bin/bash
OUT="results/startup_time.txt"

echo "=== APPLICATION STARTUP TIME ===" | tee $OUT
phoronix-test-suite benchmark startup-time | tee -a $OUT

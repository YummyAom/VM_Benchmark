#!/bin/bash

mkdir -p results

echo "=== BENCHMARK START ===" | tee results/summary.log
date | tee -a results/summary.log

scripts=(
cpu_geekbench6.sh
memory_sysbench.sh
disk_bonnie.sh
compress_7zip.sh
kernel_build.sh
startup_time.sh
network_iperf.sh
)

for s in "${scripts[@]}"; do
    if [[ -f "$s" ]]; then
        echo "Running $s..." | tee -a results/summary.log
        bash "$s"
        sleep 10 
    else
        echo "Warning: $s not found!" | tee -a results/summary.log
    fi
done

echo "=== BENCHMARK END ===" | tee -a results/summary.log
date | tee -a results/summary.log

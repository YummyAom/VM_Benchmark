#!/bin/bash

mkdir -p results

echo "=== BENCHMARK MANAGER START ==="

declare -A BENCHMARKS=(
    [0]="Exit"
    [1]="cpu_geekbench6.sh"
    [2]="memory_sysbench.sh"
    [3]="disk_bonnie.sh"
)

while true; do
    echo ""
    echo "Select an option:"
    echo "1) Install tools (install_tools.sh)"
    echo "2) Run CPU/Memory/Disk benchmarks"
    echo "0) Exit"
    read -p "Enter choice: " main_choice

    if [[ "$main_choice" == "1" ]]; then
        if [[ -f "install_tools.sh" ]]; then
            echo "Running install_tools.sh..." | tee -a results/summary.log
            bash install_tools.sh
            echo "Tools installation completed!" | tee -a results/summary.log
        else
            echo "install_tools.sh not found!" | tee -a results/summary.log
        fi
        continue
    fi

    if [[ "$main_choice" == "2" ]]; then
        # แสดงเมนูเลือก benchmark
        echo ""
        echo "Select benchmarks to run:"
        for i in "${!BENCHMARKS[@]}"; do
            echo "$i) ${BENCHMARKS[$i]}"
        done
        echo "0) Run ALL benchmarks"
        read -p "Enter your choice (e.g., 1 3 or 0 for all): " -a choices

        # ฟังก์ชันรัน benchmark
        run_benchmark() {
            script="$1"
            if [[ -f "$script" ]]; then
                echo "Running $script..." | tee -a results/summary.log
                bash "$script"
                sleep 5
            else
                echo "Warning: $script not found!" | tee -a results/summary.log
            fi
        }

        if [[ " ${choices[@]} " =~ "0" ]]; then
            for s in "${BENCHMARKS[@]}"; do
                run_benchmark "$s"
            done
        else
            for c in "${choices[@]}"; do
                if [[ -n "${BENCHMARKS[$c]}" ]]; then
                    run_benchmark "${BENCHMARKS[$c]}"
                else
                    echo "Invalid choice: $c"
                fi
            done
        fi
        continue
    fi

    if [[ "$main_choice" == "0" ]]; then
        echo "=== BENCHMARK MANAGER END ===" | tee -a results/summary.log
        date | tee -a results/summary.log
        break
    fi

    echo "Invalid choice: $main_choice"
done

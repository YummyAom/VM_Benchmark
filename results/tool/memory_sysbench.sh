OUT="results/memory.txt"
SUMMARY_DIR="summary"
SUMMARY_FILE="results/$SUMMARY_DIR/memory.txt"

mkdir -p results
mkdir -p $SUMMARY_DIR

echo "=== MEMORY SYSBENCH ===" | tee $OUT
sysbench memory run | tee -a $OUT

# ดึงค่า Data Transfer Speed
MEM_SPEED=$(grep "MiB/sec" $OUT | awk '{print $(NF-1), $NF}')

# ดึงค่า Max Latency
MAX_LATENCY=$(grep "max:" $OUT | awk '{print $2, $3}')

# เขียน summary/memory.txt
{
  echo "=== MEMORY SUMMARY ==="
  echo "Memory Transfer Speed: $MEM_SPEED"
  echo "Max Latency: $MAX_LATENCY"
  echo "Host: $(hostname)"
  echo "Time: $(date)"
  echo ""
} | tee $SUMMARY_FILE

#!/usr/bin/env bash
set -euo pipefail

watchMemory() {
  echo "log_ts,pct_mem,vsz,rss"
  while true; do
      echo "$(date '+%Y-%m-%d %H:%M:%S'),$(ps -C dolt  -o%mem=,vsz=,rss= | sed 's/^\s//g' | sed 's/\s/,/g')" 
      sleep 1
  done
}

watchMemory | tee memorylog.csv

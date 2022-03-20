#!/usr/bin/env bash
set -euo pipefail

watchMemory() {
  echo "log_ts,pct_mem,vsz,rss"
  while true; do
    for p in $(ps -C dolt  -o%mem=,vsz=,rss= | sed 's/^\s//g' | sed 's/\s/,/g')
    do
        echo "$(date +%s),$p"
    done
    sleep 1
  done
}

watchMemory | tee memorylog.csv
